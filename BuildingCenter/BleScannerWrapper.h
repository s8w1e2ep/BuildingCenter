//
//  NSObject+BleScannerWrapper.h
//  NitigationKit
//
//  Created by 安西一街 on 2017/4/18.
//  Copyright © 2017年 安西一街. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BeaconScanResultListener <NSObject>
-(void)onBeaconScanResult:(NSDictionary *)beaconMap;
@end

@interface BleScannerWrapper: NSObject

@property (nonatomic, weak)id <BeaconScanResultListener> beaconScanResultListener;
@property (nonatomic, copy)NSString *scanDeviceName;
@property (nonatomic, assign)float scanPeriod; // in milliseconds
@property (nonatomic, assign)float scanPause; // in milliseconds
@property (nonatomic, assign)NSUInteger rssiThreshold;
@property (nonatomic, assign)NSInteger powerLevelWarningThreshold;

+ (BleScannerWrapper *)getInstance;
-(void)startBleScan;
-(void)stopBleScan;
-(NSDictionary *)getPowerInfo;

@end
