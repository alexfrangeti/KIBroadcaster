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

// Called on beacon state change, power on
- (void)beaconDidPowerOn;

// Called on beacon state change, power off
- (void)beaconDidPowerOff;

// Called on bluetooth state change, on
- (void)bluetoothDidPowerOn;

// Called on bluetooth state change, off
- (void)bluetoothDidPowerOff;

// Called on advertising start
- (void)advertisingDidStart;

// Called on advertising stop
- (void)advertisingDidStop;

// Called on any error that the manager signals
- (void)onError:(NSError *)error;

@end

@interface KIBeaconTransmitter : NSObject<CBPeripheralManagerDelegate, CBCentralManagerDelegate>

// The manager's delegate object
@property (weak) id<KIBeaconTransmitterDelegate>broadcastDelegate;

// BOOL ivar for the bluetooth service state
@property (nonatomic) BOOL bluetoothServiceState;

// The constructor
- (instancetype)initWithDelegate:(id<KIBeaconTransmitterDelegate>)delegate;

- (void)startAdvertising;
- (void)stopAdvertising;

// Info relay method for the beacon's data ( UUID, major, minor )
- (NSString *)getBeaconInfo;

@end
