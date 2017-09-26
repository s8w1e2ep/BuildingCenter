//
//  NSObject+BleScannerWrapper.m
//  NitigationKit
//
//  Created by 安西一街 on 2017/4/18.
//  Copyright © 2017年 安西一街. All rights reserved.
//

#import "BleScannerWrapper.h"
#import "BLE.h"

NSInteger const SCAN_PERIOD = 2000;
NSInteger const SCAN_PAUSE_PERIOD = 2000;
NSInteger const POWER_LEVEL_WARNING_THRESHOLD = 20;
NSInteger const RSSI_THRESHOLD = -70;

static BleScannerWrapper *sharedInstance = nil;

@interface BleScannerWrapper() <BLEDelegate> {
    BLE *ble;

    NSThread *scanThread;
    NSCondition* condition;
    BOOL lock;
    
    NSRange macRange;
    NSMutableDictionary *bleRssiMapByMac;
    NSMutableDictionary *powerLevelRecord;
}
@end

@implementation BleScannerWrapper: NSObject

+ (BleScannerWrapper *)getInstance {
    if (!sharedInstance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            sharedInstance = [[super alloc] init];
            [sharedInstance internalInit];

        });
    }
    return sharedInstance;
}

-(void)internalInit {
    self->ble = [BLE getSharedInstance];
    self->ble.delegate = self;
    self->bleRssiMapByMac = [[NSMutableDictionary alloc] init];
    self->powerLevelRecord = [[NSMutableDictionary alloc] init];
    
    // mac address from ble local name
    macRange = NSMakeRange(1, 17);
    
    // set default value
    self.scanPeriod = SCAN_PERIOD;
    self.scanPause = SCAN_PAUSE_PERIOD;
    self.powerLevelWarningThreshold = POWER_LEVEL_WARNING_THRESHOLD;
    self.rssiThreshold = RSSI_THRESHOLD;
    
    // scan thread control
    self->condition = [[NSCondition alloc] init];
}

-(void)scanRoutine {
    double scanPeriodInSecond = (double)sharedInstance.scanPeriod / (double)1000;
    @autoreleasepool {
        while ([scanThread isCancelled] == NO) {
            self->lock = YES;
            if (ble.peripherals) {
                [ble.peripherals removeAllObjects];
            }
            
            // start to scan BLE devices
            [ble findBLEPeripherals:scanPeriodInSecond];
            
            // pause scan
            [condition lock];
            while (self->lock == YES) {
                [condition wait];
                //NSLog(@"wait!");
            }
            [condition unlock];
        }
    }
    [NSThread exit];
}

- (void)startBleScan {
    //NSLog(@"scanBLE()");
    
    if (scanThread == nil) {
        scanThread = [[NSThread alloc]initWithTarget:self selector:@selector(scanRoutine) object:nil];
        [scanThread start];
    }
}

-(void)stopBleScan {
    if (scanThread != nil) {
        [scanThread cancel];
        scanThread = nil;
        
        [self->ble stopScan];
    }
}

-(NSDictionary *)getPowerInfo {
    return self->powerLevelRecord;
}

#pragma -- ble callback

-(void)processScanResult {
    NSDictionary *deepCopyBles = [[NSDictionary alloc] initWithDictionary:self->bleRssiMapByMac copyItems:YES];
    if (self.beaconScanResultListener && [self.beaconScanResultListener respondsToSelector:@selector(onBeaconScanResult:)]) {
        [self.beaconScanResultListener onBeaconScanResult:deepCopyBles];
    }
    
    [bleRssiMapByMac removeAllObjects];
}

-(void)continueScan {
    // scan done
    [self->condition lock];
    self->lock = NO;
    [self->condition signal];
    [self->condition unlock];
    //NSLog(@"wakeup!");
}

-(void)bleDidScan {
    [self processScanResult];
    
    double scanPauseInSecond = self.scanPause / 1000;
    [NSTimer scheduledTimerWithTimeInterval:scanPauseInSecond target:self selector:@selector(continueScan) userInfo:nil repeats:NO];
}

- (void)onScanResult:(NSString *)localName rssi:(NSInteger)rssi {
    if ([localName characterAtIndex:0] == '[' && [localName characterAtIndex:18] == ']' && [localName characterAtIndex:19] == '@') {
        NSArray *substrings = [localName componentsSeparatedByString:@"@"];
        NSString *mac = [[substrings objectAtIndex:0] substringWithRange:macRange];
        if (rssi > self.rssiThreshold) {
            //NSLog(@"mac address = %@, rssi = %li", mac, rssi);
            [self->bleRssiMapByMac setValue:[NSNumber numberWithInteger:rssi] forKey:mac];
        }
        if (substrings.count == 2) {
             // has mac and power
            [self processBeaconPower:mac beaconPowerInHex:[substrings objectAtIndex:1]];
        }
    }
}

-(void)processBeaconPower: (NSString *)mac beaconPowerInHex:(NSString *)beaconPowerInHex  {
    unsigned int result = 0;
    NSScanner *scanner = [NSScanner scannerWithString:beaconPowerInHex];
    [scanner scanHexInt:&result];
    
    //NSLog(@"mac = %@, power = %d", mac, result);
    [self->powerLevelRecord setValue:[NSNumber numberWithInt:result] forKey:mac];
}

@end
