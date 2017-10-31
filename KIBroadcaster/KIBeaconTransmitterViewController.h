//
//  KIBeaconTransmitterViewController.h
//  KIBroadcaster
//
//  Created by Alexandru Frangeti on 2017-10-30.
//  Copyright © 2017 Alexandru Frangeti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface KIBeaconTransmitterViewController : UIViewController <CBCentralManagerDelegate>

@property (weak) IBOutlet UILabel *titleLabel;
@property (weak) IBOutlet UILabel *btStatusLabel;

@end

