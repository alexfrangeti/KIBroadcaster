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
    CBCentralManager *btManager;
}

@end

@implementation KIBeaconTransmitterViewController

@synthesize titleLabel, btStatusLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Setup the CoreBluetooth discovery manager, operations on main queue (nil)
    btManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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

#pragma mark CBCentralManagerDelegate methods

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    NSString *btStatusString = @"OFF";
    switch ([self isBluetoothPoweredOn]) {
        case YES:
            NSLog(@"bluetooth is on");
            btStatusString = @"ON";
            break;
        case NO:
            NSLog(@"bluetooth is off");
            
            // If Bluetooth is not turned on, alert the user
            [self showAlertForBTSettings];
            break;
        default:
            break;
    }
    
    // Update the BT status label
    [self updateBtStatusLabelWithState:btStatusString];
}

@end
