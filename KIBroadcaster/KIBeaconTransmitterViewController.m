//
//  KIBeaconTransmitterViewController.m
//  KIBroadcaster
//
//  Created by Alexandru Frangeti on 2017-10-30.
//  Copyright © 2017 Alexandru Frangeti. All rights reserved.
//

#import "KIBeaconTransmitterViewController.h"

@interface KIBeaconTransmitterViewController() {
    // CoreBluetooth discovery manager
    
    KIBeaconTransmitter *transmitter;
    BOOL beaconIsBroadcasting;
    BOOL beaconPowerIsOn;
}

@end

@implementation KIBeaconTransmitterViewController

@synthesize titleLabel, btStatusLabel, beaconDataLabel;
@synthesize btBroadcastButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Setup the beacon transmitter
    transmitter = [[KIBeaconTransmitter alloc] initWithDelegate:self];
    
    //Setup the dataLabel with the beacon info.
    [beaconDataLabel setText:[transmitter getBeaconInfo]];
}

- (void)showAlertForBTSettings {
    UIAlertController *btAlertController = [UIAlertController alertControllerWithTitle:@"Bluetooth" message:@"Please turn on Bluetooth!" preferredStyle:UIAlertControllerStyleAlert];
    
    // Cancel action with a redirect to open up the settings if supported
    UIAlertAction *btCancelAction = [UIAlertAction actionWithTitle:@"Settings" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if (settingsURL) {
            [[UIApplication sharedApplication] openURL:settingsURL options:[NSDictionary new] completionHandler:nil];
        }
    }];
    [btAlertController addAction:btCancelAction];
    
    // Positive action, no handler
    UIAlertAction *btOkAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [btAlertController addAction:btOkAction];
    
    // Present the AlertController
    [self presentViewController:btAlertController animated:YES completion:nil];
}

- (void) updateBtStatusLabelWithState:(NSString *)state {
    NSString *stateString = [NSString stringWithFormat:@"Bluetooth status: %@", state];
    [btStatusLabel setText:stateString];
}

- (IBAction)toggleBroadcasting:(id)sender {
    if (!beaconIsBroadcasting) {
        
        // Start broadcasting, if BT is on
        if (transmitter.bluetoothServiceState) {
            [transmitter startAdvertising];
            beaconIsBroadcasting = YES;
            [btBroadcastButton setTitle:@"Stop Broadcasting" forState:UIControlStateNormal];
        } else {
            [self showAlertForBTSettings];
        }
    } else {
        [transmitter stopAdvertising];
        beaconIsBroadcasting = NO;
        [btBroadcastButton setTitle:@"Start Broadcasting" forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark KIBeaconTransmitterDelegate methods

- (void)beaconDidPowerOn {
    beaconPowerIsOn = YES;
}

- (void)beaconDidPowerOff {
    beaconPowerIsOn = NO;
}

- (void)bluetoothDidPowerOn {
    [self updateBtStatusLabelWithState:@"ON"];
}

- (void)bluetoothDidPowerOff {
    [self updateBtStatusLabelWithState:@"OFF"];
}

- (void)advertisingDidStart {
    NSString *beaconInfo = [transmitter getBeaconInfo];
    NSLog(@"got beaconInfo: %@", beaconInfo);
    [beaconDataLabel setText:beaconInfo];
}

- (void)advertisingDidStop {
    NSString *beaconInfo = [transmitter getBeaconInfo];
    [beaconDataLabel setText:beaconInfo];
}

- (void)onError:(NSError *)error {
    //No specific implementation for the current scope
}

@end
