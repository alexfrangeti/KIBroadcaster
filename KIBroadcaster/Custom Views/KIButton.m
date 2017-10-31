//
//  KIButton.m
//  KIBroadcaster
//
//  Created by Alexandru Frangeti on 31.10.2017.
//  Copyright © 2017 Alexandru Frangeti. All rights reserved.
//

#import "KIButton.h"

@interface KIButton()

@end

@implementation KIButton

// Constructor. Accept custom init case the view is customized from IB
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.borderWidth    = 2;
        self.cornerRadius  = 10;
        self.borderColor   = [UIColor whiteColor];
        
        [self customInit];
    }
    return self;
}

// NSCoder support. Dearchiving followed by custom init
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self customInit];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [self customInit];
}

- (void)setNeedsLayout {
    [super setNeedsLayout];
    // Set needsDisplay so the IB changes are picked up
    [self setNeedsDisplay];
}

// In order for IB to be able to set props directly
- (void)prepareForInterfaceBuilder {
    [self customInit];
}

// Custom init, setting up view params based on ctor / IB specs
- (void)customInit {
    
    self.layer.cornerRadius = self.cornerRadius;
    self.layer.borderWidth = self.borderWidth;
    self.layer.borderColor = self.borderColor.CGColor;
    
    // If the radius is positive, we need to mask the view's layer
    if (self.cornerRadius > 0) {
        self.layer.masksToBounds = YES;
    }
    
}

@end
