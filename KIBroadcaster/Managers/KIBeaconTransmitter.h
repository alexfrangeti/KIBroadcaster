//
//  KIBeaconTransmitter.h
//  KIBroadcaster
//
//  Created by Alexandru Frangeti on 2017-10-30.
//  Copyright © 2017 Alexandru Frangeti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>

// BeaconTransmitterDelegate
// Protocol. Ensures that the methods listed below are implemented
// by the transmitter delegate object.
@protocol KIBeaconTransmitterDelegate <NSObject>
@required

// Called on state change, power on
- (void)didPowerOn;

// Called on state change, power off
- (void)didPowerOff;

// Called on any error that the manager signals
- (void)onError:(NSError *)error;

@end

@interface KIBeaconTransmitter : NSObject<CBPeripheralManagerDelegate>

// The manager's delegate object
@property (weak) id<KIBeaconTransmitterDelegate>broadcastDelegate;

// The sole constructor
- (instancetype)initWithDelegate:(id<KIBeaconTransmitterDelegate>)delegate;

@end
