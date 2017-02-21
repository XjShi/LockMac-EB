//
//  BLEService.m
//  LockMac
//
//  Created by xjshi on 21/02/2017.
//  Copyright © 2017 sxj. All rights reserved.
//

#import "BLEService.h"
#include <CoreBluetooth/CoreBluetooth.h>
#import "LockService.h"

@interface BLEService ()<CBCentralManagerDelegate, CBPeripheralDelegate>

@property (copy) NSString *modelName;
@property (strong) CBCentralManager *centralManager;
@property (strong) CBPeripheral *peripheral;
@property (assign) NSInteger reconnectCount;

@end

@implementation BLEService

- (instancetype)initWithiDeviceModelName:(NSString *)name {
    self = [self init];
    self.modelName = name;
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

#pragma mark - CBCentralManagerDelegate

#pragma mark - private
- (void)commonInit {
    self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    if (self.centralManager.state == CBCentralManagerStatePoweredOn && !self.peripheral) {
        [self.centralManager scanForPeripheralsWithServices:nil options:nil];
    }
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    if (self.centralManager.state == CBCentralManagerStatePoweredOn) {
        if (self.peripheral) {
            [self.centralManager connectPeripheral:_peripheral options:nil];
        } else {
            [self.centralManager scanForPeripheralsWithServices:nil options:nil];
        }
    }
}

- (void)centralManager:(CBCentralManager *)central
 didDiscoverPeripheral:(CBPeripheral *)peripheral
     advertisementData:(NSDictionary<NSString *,id> *)advertisementData
                  RSSI:(NSNumber *)RSSI {
    if ([peripheral.name isEqualToString:self.modelName]) {
        if (!self.peripheral) {
            self.peripheral = peripheral;
            self.peripheral.delegate = self;
        }
        [self.centralManager connectPeripheral:peripheral options:nil];
    }
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    self.reconnectCount = 0;
    [peripheral readRSSI];
}

- (void)centralManager:(CBCentralManager *)central
didFailToConnectPeripheral:(CBPeripheral *)peripheral
                 error:(NSError *)error {
    
}

- (void)centralManager:(CBCentralManager *)central
didDisconnectPeripheral:(CBPeripheral *)peripheral
                 error:(NSError *)error {
    if (self.reconnectCount++ < 3) {
        [self.centralManager connectPeripheral:peripheral options:nil];
    }
}

#pragma mark - CBPeripheralDelegate
- (void)peripheralDidUpdateRSSI:(CBPeripheral *)peripheral error:(NSError *)error {
    if (error) {
        NSLog(@"%@", error.localizedDescription);
    }
    float rssi = peripheral.RSSI.floatValue;
    if (rssi < -70) {
        [LockService lock];
    } else {
        [LockService unlock];
    }
}

@end
