
/*
 
 Copyright (c) 2013 RedBearLab
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
*/

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

typedef enum {
    MEM_TYPE_SUOTA_I2C            = 0x12,
    MEM_TYPE_SUOTA_SPI            = 0x13,
    MEM_TYPE_SPOTA_SYSTEM_RAM     = 0x00,
    MEM_TYPE_SPOTA_RETENTION_RAM  = 0x01,
    MEM_TYPE_SPOTA_I2C            = 0x02,
    MEM_TYPE_SPOTA_SPI            = 0x03
} MEM_TYPE;

typedef enum {
    // Value zero must not be used !! Notifications are sent when status changes.
    SPOTAR_SRV_STARTED      = 0x01,     // Valid memory device has been configured by initiator. No sleep state while in this mode
    SPOTAR_CMP_OK           = 0x02,     // SPOTA process completed successfully.
    SPOTAR_SRV_EXIT         = 0x03,     // Forced exit of SPOTAR service.
    SPOTAR_CRC_ERR          = 0x04,     // Overall Patch Data CRC failed
    SPOTAR_PATCH_LEN_ERR    = 0x05,     // Received patch Length not equal to PATCH_LEN characteristic value
    SPOTAR_EXT_MEM_WRITE_ERR= 0x06,     // External Mem Error (Writing to external device failed)
    SPOTAR_INT_MEM_ERR      = 0x07,     // Internal Mem Error (not enough space for Patch)
    SPOTAR_INVAL_MEM_TYPE   = 0x08,     // Invalid memory device
    SPOTAR_APP_ERROR        = 0x09,     // Application error
    
    // SUOTAR application specific error codes
    SPOTAR_IMG_STARTED      = 0x10,     // SPOTA started for downloading image (SUOTA application)
    SPOTAR_INVAL_IMG_BANK   = 0x11,     // Invalid image bank
    SPOTAR_INVAL_IMG_HDR    = 0x12,     // Invalid image header
    SPOTAR_INVAL_IMG_SIZE   = 0x13,     // Invalid image size
    SPOTAR_INVAL_PRODUCT_HDR= 0x14,     // Invalid product header
    SPOTAR_SAME_IMG_ERR     = 0x15,     // Same Image Error
    SPOTAR_EXT_MEM_READ_ERR = 0x16,     // Failed to read from external memory device
    
} SPOTA_STATUS_VALUES;

// advertisement tag
#define KCBADVDATA_LOCALNAME                                    "kCBAdvDataLocalName"
#define LOCAL_NAME                                              "localName"
#define KCBADVDATA_SERVICE_UUIDS                                "kCBAdvDataServiceUUIDs"
#define SERVICE_UUIDS                                           "serviceUUIDs"
#define KCBADVDATA_TXPOWER_LEVEL                                "kCBAdvDataTxPowerLevel"
#define TXPOWER_LEVEL                                           "txPowerLevel"
#define KCBADVDATA_SERVICE_DATA                                 "kCBAdvDataServiceData"
#define SERVICE_DATA                                            "serviceData"
#define KCBADVDATALOCAL_NAME                                    "kCBAdvDataManufacturerData"
#define MANUFACTURER_DATA                                       "manufacturerData"
#define KCBADVDATA_OVERFLOW_SERVICE_UUIDS                       "kCBAdvDataOverflowServiceUUIDs"
#define OVERFLOW_SERVICE_UUIDS                                  "overflowServiceUUIDs"
#define KCBADVDATA_ISCONNECTABLE                                "kCBAdvDataIsConnectable"
#define ISCONNECTABLE                                           "isConnectable"
#define KCBADCDATA_SOLICITED_SERVICE_UUIDS                      "kCBAdvDataSolicitedServiceUUIDs"
#define SOLICITED_SERVICE_UUIDS                                 "solicitedServiceUUIDs"

#define ORG_BLUETOOTH_CHARACTERISTIC_MANUFACTURER_NAME_STRING       0x2A29
#define ORG_BLUETOOTH_CHARACTERISTIC_MODEL_NUMBER_STRING            0x2A24
#define ORG_BLUETOOTH_CHARACTERISTIC_SERIAL_NUMBER_STRING           0x2A25
#define ORG_BLUETOOTH_CHARACTERISTIC_HARDWARE_REVISION_STRING       0x2A27
#define ORG_BLUETOOTH_CHARACTERISTIC_FIRMWARE_REVISION_STRING       0x2A26
#define ORG_BLUETOOTH_CHARACTERISTIC_SOFTWARE_REVISION_STRING       0x2A28
#define ORG_BLUETOOTH_CHARACTERISTIC_SYSTEM_ID                      0x2A23
#define ORG_BLUETOOTH_CHARACTERISTIC_IEEE_11073                     0x2A2A
#define ORG_BLUETOOTH_CHARACTERISTIC_PNP_ID                         0x2A50

#define BLE_RECEIVE_VALUE_NOTIFICATION                          "DidReceiveValue"
#define BLE_WRITE_VALUE_NOTIFICATION                            "DidWriteValue"


#define SCAN_TIME   5


@protocol BLEDelegate <NSObject>
@optional
- (void)bleDidScan;
- (void)onScanResult:(NSString *)localName rssi:(NSInteger)rssi;
- (void)bleDidReadyToConnect;
- (void)bleDidConnect;
- (void)bleDidFailToConnect;
- (void)bleDidDisconnect;
- (void)bleDidUpdateRSSI:(NSNumber *)rssi;
- (void)bleDidReceiveData:(CBUUID *)UUID data:(NSString *)pData;
@required
@end

@interface BLE : NSObject <CBCentralManagerDelegate, CBPeripheralDelegate> {
    
}

@property (nonatomic,assign) id <BLEDelegate> delegate;
//@property (strong, nonatomic) NSMutableArray *peripherals;
@property (strong, nonatomic) NSMutableDictionary *peripherals;
@property (strong, nonatomic) CBCentralManager *centralManager;
@property (strong, nonatomic) CBPeripheral *activePeripheral;

+ (BLE *)getSharedInstance;

// BLE control APIs
- (BOOL)isConnected;
- (int)findBLEPeripherals:(int) timeout;
- (void)stopScan;
- (void)connectPeripheral:(CBPeripheral *)peripheral;
- (CBPeripheral *)getPeripheralByDeviceId:(NSString *)deviceId;
- (void)disconnect;

// DSPS APIs
- (void)read;
- (void)write:(NSData *)pData;
- (void)writeString:(NSString *)pData;
- (void)readRSSI;

// BLE APIs
- (void)notification:(CBUUID *)serviceUUID characteristicUUID:(CBUUID *)characteristicUUID peripheral:(CBPeripheral *)pCBPeripheral on:(BOOL)on;
- (void) writeValue:(CBUUID*)serviceUUID characteristicUUID:(CBUUID*)characteristicUUID peripheral:(CBPeripheral *)pCBPeripheral data:(NSData *)data;
- (void) writeValueWithoutResponse:(CBUUID*)serviceUUID characteristicUUID:(CBUUID*)characteristicUUID peripheral:(CBPeripheral *)pCBPeripheral data:(NSData *)data;

- (UInt16)CBUUIDToInt:(CBUUID *)pUUID;
- (CBUUID *)IntToCBUUID:(UInt16)UUID;

@end
