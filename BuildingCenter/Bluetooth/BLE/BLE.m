
/*
 
 Copyright (c) 2013 RedBearLab
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
*/

#import "BLE.h"
#import "BLEDefines.h"
#import "NSData+Base64.h"
#import "MacroDefinition.h"

static BLE *sharedInstance = nil;

@interface BLE() {
    BOOL isConnected;
    NSInteger rssi;
    NSTimer *scanTimer;
    
    NSString *serviceModeUuid;
}

@end

@implementation BLE

@synthesize delegate;
@synthesize centralManager;
@synthesize peripherals;
@synthesize activePeripheral;

+ (BLE *)getSharedInstance {
    if (!sharedInstance) {
        sharedInstance = [[super allocWithZone:NULL]init];
        [sharedInstance controlSetup];
    }
    return sharedInstance;
}

- (void)readRSSI {
    [activePeripheral readRSSI];
}

- (BOOL)isConnected {
    return isConnected;
}

- (void)read {
    CBUUID *uuid_service = [CBUUID UUIDWithString:@SPS_SERVICE_UUID];
    CBUUID *uuid_char = [CBUUID UUIDWithString:@SPS_TX_UUID];
    
    [self readValue:uuid_service characteristicUUID:uuid_char peripheral:activePeripheral];
}

- (void)write:(NSData *)pData {
    CBUUID *uuid_service = [CBUUID UUIDWithString:@SPS_SERVICE_UUID];
    CBUUID *uuid_char = [CBUUID UUIDWithString:@SPS_RX_UUID];
    
    [self writeValue:uuid_service characteristicUUID:uuid_char peripheral:activePeripheral data:pData];
}

- (void)writeString:(NSString *)pData {
    CBUUID *uuid_service = [CBUUID UUIDWithString:@SPS_SERVICE_UUID];
    CBUUID *uuid_char = [CBUUID UUIDWithString:@SPS_RX_UUID];
    
    NSData *aData = [pData dataUsingEncoding:NSUTF8StringEncoding];
    
    // write string without didWriteValueForCharacteristic callback
    [self writeValueWithoutResponse:uuid_service characteristicUUID:uuid_char peripheral:activePeripheral data:aData];
}

- (void)enableReadNotification:(CBPeripheral *)pCBPeripheral {
    CBUUID *uuid_service = [CBUUID UUIDWithString:@SPS_SERVICE_UUID];
    CBUUID *uuid_char = [CBUUID UUIDWithString:@SPS_TX_UUID];
    
    [self notification:uuid_service characteristicUUID:uuid_char peripheral:pCBPeripheral on:YES];
}

- (void)notification:(CBUUID *)serviceUUID characteristicUUID:(CBUUID *)characteristicUUID peripheral:(CBPeripheral *)pCBPeripheral on:(BOOL)on {
    CBService *service = [self findServiceFromUUID:serviceUUID p:pCBPeripheral];
    
    if (!service) {
        NSLog(@"Could not find service with UUID %@ on peripheral with UUID %@",
               [self CBUUIDToString:serviceUUID],
               pCBPeripheral.identifier.UUIDString);
        
        return;
    }
    
    CBCharacteristic *characteristic = [self findCharacteristicFromUUID:characteristicUUID service:service];
    
    if (!characteristic) {
        NSLog(@"Could not find characteristic with UUID %@ on service with UUID %@ on peripheral with UUID %@",
              [self CBUUIDToString:characteristicUUID],
              [self CBUUIDToString:serviceUUID],
              pCBPeripheral.identifier.UUIDString);
        
        return;
    }
    
    [pCBPeripheral setNotifyValue:on forCharacteristic:characteristic];
}

/*
- (NSString *)CBUUIDToStringLong:(CBUUID *)uuid {
    unsigned char base[16] = {0x00,0x00,0x00,0x00,  0x00,0x00,  0x10,0x00,  0x80,0x00, 0x00,0x80,0x5f,0x9b,0x34,0xfb};
    const unsigned char *bytes = [[uuid data] bytes];
    if (uuid.data.length == 2){
        memcpy(base+2, bytes, 2);
    }else if((uuid.data.length == 4) || (uuid.data.length == 16)){
        memcpy(base, bytes, uuid.data.length);
    }
    NSMutableString *string = [NSMutableString stringWithCapacity:20];
    for (int i = 0; i < 16; i++){
        switch (i){
            case 3:
            case 5:
            case 7:
            case 9: [string appendFormat:@"%02x-", base[i]]; break;
            default:[string appendFormat:@"%02x",  base[i]]; break;
        }
    }
    NSLog(@"CBUUIDFiltrToString <:  %@", string);
    return string;
}
*/

- (NSString *)CBUUIDToString:(CBUUID *) cbuuid {
    NSData *data = cbuuid.data;
    
    if ([data length] == 2) {
        const unsigned char *tokenBytes = [data bytes];
        return [NSString stringWithFormat:@"%02x%02x", tokenBytes[0], tokenBytes[1]];
    } else if ([data length] == 16) {
        NSUUID* nsuuid = [[NSUUID alloc] initWithUUIDBytes:[data bytes]];
        return [nsuuid UUIDString];
    }
    
    return [cbuuid description];
}

- (void)readValue: (CBUUID *)serviceUUID characteristicUUID:(CBUUID *)characteristicUUID peripheral:(CBPeripheral *)pCBPeripheral {
    CBService *service = [self findServiceFromUUID:serviceUUID p:pCBPeripheral];
    
    if (!service) {
        NSLog(@"Could not find service with UUID %@ on peripheral with UUID %@",
              [self CBUUIDToString:serviceUUID],
              pCBPeripheral.identifier.UUIDString);
        
        return;
    }
    
    CBCharacteristic *characteristic = [self findCharacteristicFromUUID:characteristicUUID service:service];
    
    if (!characteristic)
    {
        NSLog(@"Could not find characteristic with UUID %@ on service with UUID %@ on peripheral with UUID %@",
              [self CBUUIDToString:characteristicUUID],
              [self CBUUIDToString:serviceUUID],
              pCBPeripheral.identifier.UUIDString);
        
        return;
    }
    
    [pCBPeripheral readValueForCharacteristic:characteristic];
}

- (void)writeValue:(CBUUID*)serviceUUID characteristicUUID:(CBUUID*)characteristicUUID peripheral:(CBPeripheral *)pCBPeripheral data:(NSData *)data andResponseType:(CBCharacteristicWriteType)responseType {
    CBService *service = [self findServiceFromUUID:serviceUUID p:pCBPeripheral];
    if (!service) {
        NSLog(@"Could not find service with UUID %@ on peripheral with UUID %@\r\n",[self CBUUIDToString:serviceUUID], pCBPeripheral.identifier);
        return;
    }
    CBCharacteristic *characteristic = [self findCharacteristicFromUUID:characteristicUUID service:service];
    if (!characteristic) {
        NSLog(@"Could not find characteristic with UUID %@ on service with UUID %@ on peripheral with UUID %@\r\n", [self CBUUIDToString:characteristicUUID],[self CBUUIDToString:serviceUUID], pCBPeripheral.identifier);
        return;
    }
    [pCBPeripheral writeValue:data forCharacteristic:characteristic type:responseType];
}

- (void)writeValue:(CBUUID*)serviceUUID characteristicUUID:(CBUUID*)characteristicUUID peripheral:(CBPeripheral *)pCBPeripheral data:(NSData *)data {
    [self writeValue:serviceUUID characteristicUUID:characteristicUUID peripheral:pCBPeripheral data:data andResponseType:CBCharacteristicWriteWithResponse];
}

- (void)writeValueWithoutResponse:(CBUUID*)serviceUUID characteristicUUID:(CBUUID*)characteristicUUID peripheral:(CBPeripheral *)pCBPeripheral data:(NSData *)data {
    [self writeValue:serviceUUID characteristicUUID:characteristicUUID peripheral:pCBPeripheral data:data andResponseType:CBCharacteristicWriteWithoutResponse];
}

- (UInt16)swap:(UInt16)s {
    UInt16 temp = s << 8;
    temp |= (s >> 8);
    return temp;
}

- (void)controlSetup {
    self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    //self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil options:@{ CBCentralManagerOptionRestoreIdentifierKey:@"myCentralManagerIdentifier" }];
}

- (int)findBLEPeripherals:(int) timeout {
    /*
    if (self.centralManager.state != CBCentralManagerStatePoweredOn) {
        NSLog(@"CoreBluetooth not correctly initialized !");
        NSLog(@"State = %ld (%s)\r\n", (long)self.centralManager.state, [self centralManagerStateToString:self.centralManager.state]);
        return -1;
    }
     */
    
    // surrounded in the dispatch_async when use timer in the framework
    dispatch_async(dispatch_get_main_queue(), ^{
        scanTimer = [NSTimer scheduledTimerWithTimeInterval:(float)timeout target:self selector:@selector(scanTimeOut:) userInfo:nil repeats:NO];
    });
    
    [self.centralManager scanForPeripheralsWithServices:nil options:nil];
    
    //NSLog(@"findBLEPeripherals()");
    
    return 0; // Started scanning OK !
}

- (void)stopScan {
    if (scanTimer != nil) {
        [scanTimer invalidate];
    }
    [self.centralManager stopScan];
}

- (void)connectPeripheral:(CBPeripheral *)peripheral {
    NSLog(@"Connecting to peripheral with UUID : %@", peripheral.identifier.UUIDString);
    
    self.activePeripheral = peripheral;
    self.activePeripheral.delegate = self;
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        if(peripheral.state == CBPeripheralStateDisconnected) {
            //[self.centralManager connectPeripheral:peripheral options:nil];
            [self.centralManager connectPeripheral:self.activePeripheral
                                           options:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:CBConnectPeripheralOptionNotifyOnDisconnectionKey]];
            
        }
    } else {
        if (peripheral.state != CBPeripheralStateConnected) {
//            [self.centralManager connectPeripheral:peripheral options:nil];
            [self.centralManager connectPeripheral:self.activePeripheral
                                           options:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:CBConnectPeripheralOptionNotifyOnDisconnectionKey]];
        }
    }
}

- (CBPeripheral *)getPeripheralByDeviceId:(NSString *)deviceId {
    for (CBPeripheral *aCBPeripheral in self.peripherals) {
        if ([aCBPeripheral.identifier.UUIDString isEqualToString:deviceId]) {
            return aCBPeripheral;
        }
    }
    return nil;
}

- (void)disconnect {
    if (self.activePeripheral && (self.activePeripheral.state == CBPeripheralStateConnected || self.activePeripheral.state ==  CBPeripheralStateConnecting)) {
        [self.centralManager cancelPeripheralConnection:self.activePeripheral];
    }
}

- (const char *) centralManagerStateToString: (int)state {
    switch(state) {
        case CBCentralManagerStateUnknown:
            return "State unknown (CBCentralManagerStateUnknown)";
        case CBCentralManagerStateResetting:
            return "State resetting (CBCentralManagerStateUnknown)";
        case CBCentralManagerStateUnsupported:
            return "State BLE unsupported (CBCentralManagerStateResetting)";
        case CBCentralManagerStateUnauthorized:
            return "State unauthorized (CBCentralManagerStateUnauthorized)";
        case CBCentralManagerStatePoweredOff:
            return "State BLE powered off (CBCentralManagerStatePoweredOff)";
        case CBCentralManagerStatePoweredOn:
            return "State powered up and ready (CBCentralManagerStatePoweredOn)";
        default:
            return "State unknown";
    }
    
    return "Unknown state";
}

- (void)scanTimeOut:(NSTimer *)timer {
    //NSLog(@"scanTimeOut()");
          
    [self.centralManager stopScan];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(bleDidScan)]) {
        [delegate bleDidScan];
    }
    //NSLog(@"Stopped Scanning");

    //[self printKnownPeripherals];
}

- (void)printKnownPeripherals {
    NSLog(@"List of currently known peripherals :");
    
    int i = 0;
    for (CBPeripheral *p in [self.peripherals allValues]) {
        i++;
        if (p.identifier != NULL) {
            NSLog(@"%d  |  %@", i, p.identifier.UUIDString);
        } else {
            NSLog(@"%d  |  NULL", i);
        }
        
        [self printPeripheralInfo:p];
    }
}

- (void) printPeripheralInfo:(CBPeripheral*)peripheral {
    NSLog(@"------------------------------------");
    NSLog(@"Peripheral Info :");
    
    if (peripheral.identifier != NULL) {
        NSLog(@"UUID : %@", peripheral.identifier.UUIDString);
    } else {
        NSLog(@"UUID : NULL");
    }
    
    NSLog(@"Name : %@", peripheral.name);
    NSLog(@"-------------------------------------");
}

- (BOOL)UUIDSAreEqual:(NSUUID *)UUID1 UUID2:(NSUUID *)UUID2 {
    if ([UUID1.UUIDString isEqualToString:UUID2.UUIDString])
        return TRUE;
    else
        return FALSE;
}

-(void)getAllServicesFromPeripheral:(CBPeripheral *)p {
    [p discoverServices:nil]; // Discover all services without filter
}

-(int)compareCBUUID:(CBUUID *) UUID1 UUID2:(CBUUID *)UUID2 {
    char b1[16];
    char b2[16];
    [UUID1.data getBytes:b1];
    [UUID2.data getBytes:b2];
    
    if (memcmp(b1, b2, UUID1.data.length) == 0)
        return 1;
    else
        return 0;
}

- (int)compareCBUUIDToInt:(CBUUID *)UUID1 UUID2:(UInt16)UUID2 {
    char b1[16];
    
    [UUID1.data getBytes:b1];
    UInt16 b2 = [self swap:UUID2];
    
    if (memcmp(b1, (char *)&b2, 2) == 0)
        return 1;
    else
        return 0;
}

- (UInt16)CBUUIDToInt:(CBUUID *)pUUID {
    char b1[16];
    [pUUID.data getBytes:b1];
    return ((b1[0] << 8) | b1[1]);
}

- (CBUUID *)IntToCBUUID:(UInt16)UUID {
    /*
    char t[16];
    t[0] = ((UUID >> 8) & 0xff); t[1] = (UUID & 0xff);
    NSData *data = [[NSData alloc] initWithBytes:t length:16];
    return [CBUUID UUIDWithData:data];
    */
    
    UInt16 cz = [self swap:UUID];
    NSData *cdz = [[NSData alloc] initWithBytes:(char *)&cz length:2];
    CBUUID *cuz = [CBUUID UUIDWithData:cdz];
    return cuz;
}

- (CBService *)findServiceFromUUID:(CBUUID *)UUID p:(CBPeripheral *)pCBPeripheral {
    for (int i = 0; i < pCBPeripheral.services.count; i++) {
        CBService *s = [pCBPeripheral.services objectAtIndex:i];
        if ([self compareCBUUID:s.UUID UUID2:UUID])
            return s;
    }
    
    return nil; //Service not found on this peripheral
}

- (CBCharacteristic *)findCharacteristicFromUUID:(CBUUID *)UUID service:(CBService*)service {
    for(int i=0; i < service.characteristics.count; i++)
    {
        CBCharacteristic *c = [service.characteristics objectAtIndex:i];
        if ([self compareCBUUID:c.UUID UUID2:UUID]) return c;
    }
    
    return nil; //Characteristic not found on this service
}

#pragma mark - CBCentralManagerDelegate

- (void)centralManagerDidUpdateState:(CBCentralManager *)centralManager {
    //NSLog(@"Status of CoreBluetooth central manager changed %ld (%s)", (long)centralManager.state, [self centralManagerStateToString:centralManager.state]);
    switch (centralManager.state) {
        case CBCentralManagerStatePoweredOn:
            if (self.delegate && [self.delegate respondsToSelector:@selector(bleDidReadyToConnect)]) {
                [self.delegate bleDidReadyToConnect];
            }
            break;
        default:
            break;
    }
}

- (NSString*)encodeBase64:(NSData*)data {
    return [[[NSData alloc] initWithData:data] base64EncodedString];
}

- (NSMutableDictionary *)getAdvertisementData:(NSDictionary *)advertisementData {
    NSMutableDictionary *advertisementDataDic = [[NSMutableDictionary alloc] init];

    //NSLog(@"%@", [advertisementData valueForKey:CBAdvertisementDataManufacturerDataKey]);
    if ([advertisementData valueForKey:CBAdvertisementDataManufacturerDataKey])
        [advertisementDataDic setValue:[advertisementData valueForKey:CBAdvertisementDataManufacturerDataKey] forKey:@LOCAL_NAME];
    
    if ([advertisementData valueForKey:@KCBADVDATA_LOCALNAME])
        [advertisementDataDic setValue:[advertisementData valueForKey:@KCBADVDATA_LOCALNAME] forKey:@LOCAL_NAME];
    if ([advertisementData valueForKey:@KCBADVDATA_TXPOWER_LEVEL])
        [advertisementDataDic setValue:[advertisementData valueForKey:@KCBADVDATA_TXPOWER_LEVEL] forKey:@TXPOWER_LEVEL];
    if ([advertisementData valueForKey:@KCBADVDATA_SERVICE_DATA])
        [advertisementDataDic setValue:[advertisementData valueForKey:@KCBADVDATA_SERVICE_DATA] forKey:@SERVICE_DATA];
    if ([advertisementData valueForKey:@KCBADVDATA_ISCONNECTABLE])
        [advertisementDataDic setValue:[advertisementData valueForKey:@KCBADVDATA_ISCONNECTABLE] forKey:@ISCONNECTABLE];
    if ([advertisementData valueForKey:@KCBADVDATALOCAL_NAME]) {
        NSData *manufacturer = [advertisementData valueForKey:@KCBADVDATALOCAL_NAME];
        [advertisementDataDic setValue:[self encodeBase64:manufacturer] forKey:@MANUFACTURER_DATA];
    }
    if ([advertisementData valueForKey:@KCBADVDATA_SERVICE_UUIDS]){
        NSMutableArray *advServiceUUIDs = [advertisementData valueForKey:@KCBADVDATA_SERVICE_UUIDS];
        NSMutableArray *uuids = [[NSMutableArray alloc] init];
        for (int i = 0; i < advServiceUUIDs.count; i++)
            [uuids addObject:[self CBUUIDToString:[advServiceUUIDs objectAtIndex:i]]];
        [advertisementDataDic setValue:uuids forKey:@SERVICE_UUIDS];
    }
    if ([advertisementData valueForKey:@KCBADVDATA_OVERFLOW_SERVICE_UUIDS]){
        NSMutableArray *uuids = [[NSMutableArray alloc] init];
        NSMutableArray *overFlowAdvServiceUUIDs = [advertisementData valueForKey:@KCBADVDATA_OVERFLOW_SERVICE_UUIDS];
        for (int i = 0; i < overFlowAdvServiceUUIDs.count; i++)
            [uuids addObject:[self CBUUIDToString : [overFlowAdvServiceUUIDs objectAtIndex:i]]];
        [advertisementDataDic setValue:uuids forKey:@OVERFLOW_SERVICE_UUIDS];
    }
    if ([advertisementData valueForKey:@KCBADCDATA_SOLICITED_SERVICE_UUIDS]){
        NSMutableArray *uuids = [[NSMutableArray alloc] init];
        NSMutableArray *solicitedAdvServiceUUIDs = [advertisementData valueForKey:@KCBADCDATA_SOLICITED_SERVICE_UUIDS];
        for (int i = 0; i < solicitedAdvServiceUUIDs.count; i++)
            [uuids addObject:[self CBUUIDToString:[solicitedAdvServiceUUIDs objectAtIndex:i]]];
        [advertisementDataDic setValue:uuids forKey:@SOLICITED_SERVICE_UUIDS];
    }
    return advertisementDataDic;
}

- (void)logScanDeviceUUID:(NSString *)deviceUUID RSSI:(NSString *)deviceRSSI advData:(NSMutableDictionary *)advertisementData {
    NSString *scanDeviceInfo = [NSString stringWithFormat:@"device = %@  scan rssi = %@  adv:", deviceUUID, deviceRSSI];
    
    for (NSString *key in [advertisementData allKeys]) {
        scanDeviceInfo = [scanDeviceInfo stringByAppendingString:
                          [NSString stringWithFormat:@"%@ = %@; ", key, [advertisementData valueForKey:key]]];
    }
    
    NSLog(@"%@", scanDeviceInfo);
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {
    // print all peripheral information
    //NSMutableDictionary *localAdvertisementData = [self getAdvertisementData:advertisementData];
    //[self logScanDeviceUUID:peripheral.identifier.UUIDString RSSI:[NSString stringWithFormat:@"%@", RSSI] advData:localAdvertisementData];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(onScanResult:rssi:)]) {
        [self.delegate onScanResult:[advertisementData valueForKey:@KCBADVDATA_LOCALNAME] rssi:[RSSI intValue]];
    }
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    if (peripheral.identifier != NULL) {
        NSLog(@"Connected to %@ successful", peripheral.identifier.UUIDString);
    } else {
        NSLog(@"Connected to NULL successful");
    }
    
    self.activePeripheral = peripheral;
    [self.activePeripheral discoverServices:nil];
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    if (self.delegate && [self.delegate respondsToSelector:@selector(bleDidDisconnect)]) {
        [self.delegate bleDidDisconnect];
    }
    
    isConnected = false;
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    if (self.delegate && [self.delegate respondsToSelector:@selector(bleDidFailToConnect)]) {
        [self.delegate bleDidFailToConnect];
    }
}


#pragma mark - CBPeripheralDelegate

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    if (!error) {
        // find correct characteristics
        for (CBService *aCBService in peripheral.services) {
            // discovery all characteristics
            [peripheral discoverCharacteristics:nil forService:aCBService];
        }
    } else {
        NSLog(@"Service discovery was unsuccessful!");
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    if (!error) {
        if ([service.UUID isEqual:[CBUUID UUIDWithString:@SPS_SERVICE_UUID]]) {
            // SPS service
            for (CBCharacteristic *aCBCharacteristic in service.characteristics) {
                NSLog(@"aCBCharacteristic: %@ found", aCBCharacteristic.UUID);
            
                // register read notification
                if ([aCBCharacteristic.UUID isEqual:[CBUUID UUIDWithString:@SPS_TX_UUID]]) {
                    [self enableReadNotification:activePeripheral];
                    if (self.delegate && [self.delegate respondsToSelector:@selector(bleDidConnect)]) {
                        [self.delegate bleDidConnect];
                    }
                    isConnected = true;
                    break;
                }
            }
        //} else if ([service.UUID isEqual:[CBUUID UUIDWithString:@SUOTA_SERVICE_UUID_SHORT]]) {
        } else {
            // SUOTA service
            for (CBCharacteristic *aCBCharacteristic in service.characteristics) {
                if ([[aCBCharacteristic UUID] isEqual:[CBUUID UUIDWithString:@SPOTA_MEM_DEV_UUID]]) {
                    NSLog(@"MEM DEV FOUND!");
                }
                
                switch ([self CBUUIDToInt:aCBCharacteristic.UUID]) {
                    //case ORG_BLUETOOTH_CHARACTERISTIC_MANUFACTURER_NAME_STRING:
                    //case ORG_BLUETOOTH_CHARACTERISTIC_MODEL_NUMBER_STRING:
                    case ORG_BLUETOOTH_CHARACTERISTIC_FIRMWARE_REVISION_STRING:
                    //case ORG_BLUETOOTH_CHARACTERISTIC_SOFTWARE_REVISION_STRING:
                        NSLog(@"aCBCharacteristic: %@ found", aCBCharacteristic.UUID);
                        [self readValue:service.UUID characteristicUUID:aCBCharacteristic.UUID peripheral:peripheral];
                        break;
                }
            }
        }
    } else {
        NSLog(@"Characteristic discorvery unsuccessful!");
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    if (!error) {
        //        printf("Updated notification state for characteristic with UUID %s on service with  UUID %s on peripheral with UUID %s\r\n",[self CBUUIDToString:characteristic.UUID],[self CBUUIDToString:characteristic.service.UUID],[self UUIDToString:peripheral.UUID]);
    } else {
        NSLog(@"Error in setting notification state for characteristic with UUID %@ on service with UUID %@ on peripheral with UUID %@",
               [self CBUUIDToString:characteristic.UUID],
               [self CBUUIDToString:characteristic.service.UUID],
               peripheral.identifier.UUIDString);
        
        NSLog(@"Error code was %s", [[error description] cStringUsingEncoding:NSStringEncodingConversionAllowLossy]);
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    unsigned char data[20];
    
    static unsigned char buf[512];
    static int len = 0;
    NSInteger data_len;
    NSString *aString;
    
    if (!error) {
        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@SPS_TX_UUID]]) {
            // SPS characteristics
            data_len = characteristic.value.length;
            [characteristic.value getBytes:data length:data_len];
            
            if (data_len == 20) {
                memcpy(&buf[len], data, 20);
                len += data_len;
                
                if (len >= 64) {
                    aString = [[NSString alloc] initWithBytes:buf length:len encoding:NSUTF8StringEncoding];
                    if (self.delegate && [self.delegate respondsToSelector:@selector(bleDidReceiveData:data:)]) {
                        [self.delegate bleDidReceiveData:characteristic.UUID data:aString];
                    }
                    len = 0;
                }
            } else if (data_len < 20) {
                if (data[5] == 0xaa || data[5] == 0xbb || data[5] == 0xdd) {
                    // sensor list, 0xaa PIR, 0xbb PIR2, 0xdd DICE
                    NSString *s = [NSString stringWithFormat:@"%2X:%2X:%2X:%2X:%2X:%2X", data[5],data[4],data[3],data[2],data[1],data[0]];
                    if (self.delegate && [self.delegate respondsToSelector:@selector(bleDidReceiveData:data:)]) {
                        [self.delegate bleDidReceiveData:characteristic.UUID data:s];
                    }
                    len = 0;
                } else {
                    // pure text memssage
                    memcpy(&buf[len], data, data_len);
                    len += data_len;
                    
                    aString = [[NSString alloc] initWithBytes:buf length:len encoding:NSUTF8StringEncoding];
                    if (self.delegate && [self.delegate respondsToSelector:@selector(bleDidReceiveData:data:)]) {
                        [self.delegate bleDidReceiveData:characteristic.UUID data:aString];
                    }
                    len = 0;
                }
            }
        } else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@SPOTA_SERV_STATUS_UUID]]) {
            NSLog(@"Value for %@ is %@", [characteristic UUID], [characteristic value]);
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@BLE_RECEIVE_VALUE_NOTIFICATION object:characteristic];
        } else {
            // SUOTA characteristics
            switch ([self CBUUIDToInt:characteristic.UUID]) {
                //case ORG_BLUETOOTH_CHARACTERISTIC_MANUFACTURER_NAME_STRING:
                //case ORG_BLUETOOTH_CHARACTERISTIC_MODEL_NUMBER_STRING:
                case ORG_BLUETOOTH_CHARACTERISTIC_FIRMWARE_REVISION_STRING:
                //case ORG_BLUETOOTH_CHARACTERISTIC_SOFTWARE_REVISION_STRING:
                    aString = [[NSString alloc] initWithData:characteristic.value encoding:NSUTF8StringEncoding];
                    if (self.delegate && [self.delegate respondsToSelector:@selector(bleDidReceiveData:data:)]) {
                        [self.delegate bleDidReceiveData:characteristic.UUID data:aString];
                    }
                    break;
            }
        }
    } else {
        NSLog(@"updateValueForCharacteristic failed!");
    }
}

// called after write successfully
- (void) peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    NSLog(@"Data written: %@", error);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@BLE_WRITE_VALUE_NOTIFICATION object:characteristic];
}

- (void)peripheralDidUpdateRSSI:(CBPeripheral *)peripheral error:(NSError *)error {
    if (!isConnected)
        return;
    
    if (rssi != peripheral.RSSI.intValue)
    {
        rssi = peripheral.RSSI.intValue;
        if (self.delegate && [self.delegate respondsToSelector:@selector(bleDidUpdateRSSI:)]) {
            [self.delegate bleDidUpdateRSSI:activePeripheral.RSSI];
        }
    }
}

@end
