//
//  KIBeaconTransmitterViewController.h
//  KIBroadcaster
//
//  Created by Alexandru Frangeti on 2017-10-30.
//  Copyright © 2017 Alexandru Frangeti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "KIBeaconTransmitter.h"

@interface KIBeaconTransmitterViewController : UIViewController <KIBeaconTransmitterDelegate>

// Properties
@property (weak) IBOutlet UILabel *titleLabel;
@property (weak) IBOutlet UILabel *btStatusLabel;
@property (weak) IBOutlet UILabel *beaconDataLabel;
@property (nonatomic) IBOutlet UIButton *btBroadcastButton;

// Methods
- (IBAction)toggleBroadcasting:(id)sender;

@end

