//
//  KIBeaconTransmitter.m
//  KIBroadcaster
//
//  Created by Alexandru Frangeti on 2017-10-30.
//  Copyright © 2017 Alexandru Frangeti. All rights reserved.
//

#import "KIBeaconTransmitter.h"

@implementation KIBeaconTransmitter {
    CBPeripheralManager *manager;
    CBCentralManager *btManager;
    CLBeaconRegion *beaconRegion;
}

// Constants
NSString *const beaconRegionID = @"KIBroadcaster";
NSString *const beaconUUID = @"0636A317-770A-428E-BBB2-7FCC2D9819ED";
NSUInteger const beaconMinor = 1;
NSUInteger const beaconMajor  = 1;

@synthesize broadcastDelegate;
@synthesize bluetoothServiceState;

- (instancetype)initWithDelegate:(id<KIBeaconTransmitterDelegate>)delegate {
    self = [super init];
    if (self) {
        // We won't need a be execution queue, so the queue here is main (nil)
        manager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil];
        broadcastDelegate = delegate;
        
        // Setup the CoreBluetooth discovery manager, operations on main queue (nil)
        btManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    }
    return self;
}

- (void)startAdvertising {
    // Setup the region
    NSUUID *broadcastUUID = [[NSUUID alloc] initWithUUIDString:beaconUUID];
    CLBeaconRegion *beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:broadcastUUID major:beaconMajor minor:beaconMinor identifier:beaconRegionID];
    
    // Setup notifications for entry / exit / state on device's display
    [beaconRegion setNotifyEntryStateOnDisplay:YES];
    [beaconRegion setNotifyOnEntry:YES];
    [beaconRegion setNotifyOnExit:YES];
    
    // Get the device advertising characteristics for the passed in RSSI and beacon region
    NSDictionary *transmitData = [beaconRegion peripheralDataWithMeasuredPower:nil];
    
    [manager startAdvertising:transmitData];
    if (broadcastDelegate) {
        [broadcastDelegate advertisingDidStart];
    }
}

- (void)stopAdvertising {
    [manager stopAdvertising];
    if (broadcastDelegate) {
        [broadcastDelegate advertisingDidStop];
    }
}

- (NSString *) getBeaconInfo {
    NSString *beaconInfo = [NSString stringWithFormat:@"UUID: %@\nMajor: %lu\nMinor: %lu\nRegion: %@", beaconUUID, (unsigned long)beaconMajor, (unsigned long)beaconMinor, beaconRegionID];
    return beaconInfo;
}

#pragma mark CBCentralManager utilities

// Instance method that verifies the Bluetooth service state
- (int)isBluetoothPoweredOn {
    int state;
    switch (btManager.state) {
        case CBManagerStatePoweredOn:
            state = YES;
            break;
        case CBManagerStatePoweredOff:
            state = NO;
            break;
        default:
            state = NO;
            break;
    }
    return state;
}

#pragma mark CBPeripheralDelegate protocol methods

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral {
    if (peripheral.state == CBManagerStatePoweredOn) {
        if (broadcastDelegate) {
            [broadcastDelegate beaconDidPowerOn];
        }
    } else if (peripheral.state == CBManagerStatePoweredOff) {
        if (broadcastDelegate) {
            [broadcastDelegate beaconDidPowerOff];
        }
    }
}

#pragma mark CBCentralManagerDelegate methods

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    switch ([self isBluetoothPoweredOn]) {
        case YES:
            bluetoothServiceState = YES;
            if (broadcastDelegate) {
                [broadcastDelegate bluetoothDidPowerOn];
            }
            break;
        case NO:
            bluetoothServiceState = NO;
            if (broadcastDelegate) {
                [broadcastDelegate bluetoothDidPowerOff];
            }
            break;
        default:
            break;
    }
}

@end
