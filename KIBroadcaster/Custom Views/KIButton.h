//
//  KIButton.h
//  KIBroadcaster
//
//  Created by Alexandru Frangeti on 31.10.2017.
//  Copyright © 2017 Alexandru Frangeti. All rights reserved.
//

#import <UIKit/UIKit.h>

// So we can set the view's params from IB
IB_DESIGNABLE

@interface KIButton : UIButton

// Customizable properties via IB
@property (nonatomic) IBInspectable CGFloat cornerRadius;
@property (nonatomic) IBInspectable CGFloat borderWidth;
@property (nonatomic) IBInspectable UIColor *borderColor;

@end
