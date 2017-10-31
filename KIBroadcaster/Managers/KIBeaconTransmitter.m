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
    id<KIBeaconTransmitterDelegate>delegate;
}

@synthesize broadcastDelegate;

- (instancetype)initWithDelegate:(id<KIBeaconTransmitterDelegate>)delegate {
    self = [super init];
    if (self) {
        // We won't need a be execution queue, so the queue here is main (nil)
        manager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil];
    }
    return self;
}

- (void)startAdvertisingWithRegion:(CLBeaconRegion *)beaconRegion andPower:(NSNumber *)transmitPower {
    if (!beaconRegion || !transmitPower) {
        return;
    }
    
    // Get the device advertising characteristics for the passed in RSSI and beacon region
    NSDictionary *transmitData = [beaconRegion peripheralDataWithMeasuredPower:transmitPower];
    
    [manager startAdvertising:transmitData];
}

- (void)stopAdvertising {
    [manager stopAdvertising];
}

#pragma mark CBPeripheralDelegate protocol methods

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral {
    
}

@end
