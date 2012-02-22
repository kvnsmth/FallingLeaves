//
//  FallingLeavesViewController.m
//  FallingLeaves
//
//  Created by Kevin Smith on 6/22/11.
//  Copyright 2011 Kevin Smith. All rights reserved.
//

#import "FallingLeavesViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface FallingLeavesViewController ()

- (void)addLeaves;

@end

@implementation FallingLeavesViewController

@synthesize imageView = _imageView;

- (void)dealloc {
    [_imageView release], _imageView = nil;
    [super dealloc];
}

- (void)addLeaves {
    for (int i = 0; i < 20; i++) {
        int randomLeaf = (arc4random() % 3) + 1;
        NSString *leafFileName = [NSString stringWithFormat:@"realLeaf%d", randomLeaf];
        
        CALayer *leafLayer = [CALayer layer];
        leafLayer.contents = (id) [UIImage imageNamed:leafFileName].CGImage;
        CGRect frame = CGRectMake(0.f, -110.f, 55.f, 55.f);
        
        // position somewhere in x coordiantes
        int randomX = (arc4random() % (int)(self.imageView.frame.size.width));
        frame.origin.x = randomX;
        leafLayer.frame = frame;
        
        CFTimeInterval dropAndFadeInterval = (arc4random() % 8) + 5;
        CFTimeInterval delay = CACurrentMediaTime() + (arc4random() % 3);
        
        // drop animation
        CABasicAnimation *dropAnimation = [CABasicAnimation animationWithKeyPath:@"position.y"];
        dropAnimation.duration = dropAndFadeInterval;
        dropAnimation.beginTime = delay;
        dropAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        dropAnimation.repeatCount = INT32_MAX; // repeat a lot
        dropAnimation.fromValue=[NSNumber numberWithFloat:-110.f];
        dropAnimation.toValue=[NSNumber numberWithFloat:250.f];
        [leafLayer addAnimation:dropAnimation forKey:@"position.y"];
        
        // fade animation
        CAKeyframeAnimation *fadeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        fadeAnimation.duration = dropAndFadeInterval;
        fadeAnimation.beginTime = delay;
        fadeAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        fadeAnimation.repeatCount = INT32_MAX;
        
        fadeAnimation.values = [NSArray arrayWithObjects:[NSNumber numberWithFloat:1.f], 
                                                         [NSNumber numberWithFloat:1.f],
                                                         [NSNumber numberWithFloat:0.f], nil];
        fadeAnimation.keyTimes = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.f],
                                                           [NSNumber numberWithFloat:0.85],
                                                           [NSNumber numberWithFloat:1.f], nil];

        [leafLayer addAnimation:fadeAnimation forKey:@"opacity"];
        
        // spin animation
        leafLayer.anchorPoint = CGPointMake(0.5, -1.f);
        CFTimeInterval spinDuration = (arc4random() % 4) + 4;
        
        CGFloat startRadians;
        CGFloat endRadians;
        BOOL addFlipAnimation = (i % 2) == 0;
        if (addFlipAnimation) {
            startRadians = -50.f * (M_PI/180.f);
            endRadians = 50.f * (M_PI/180.f);
        }
        else {
            startRadians = 50.f * (M_PI/180.f);
            endRadians = -50.f * (M_PI/180.f);
        }
        
        
        CABasicAnimation *spinAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        spinAnimation.duration = spinDuration;
        spinAnimation.removedOnCompletion = NO;
        spinAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        spinAnimation.repeatCount = INT32_MAX;
        spinAnimation.autoreverses = YES;
        spinAnimation.fromValue = [NSNumber numberWithFloat:startRadians];
        spinAnimation.toValue = [NSNumber numberWithFloat:endRadians];
        [leafLayer addAnimation:spinAnimation forKey:@"transform.rotation"];
        
        if (addFlipAnimation) {
            [leafLayer setValue:[NSNumber numberWithFloat:-1.f] forKeyPath:@"transform.scale.x"];
        }
        
        [self.imageView.layer addSublayer:leafLayer];
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGColorRef borderColor = [UIColor colorWithRed:92.f/255.f green:9.f/255.f blue:10.f/255.f alpha:1.f].CGColor;
    self.imageView.layer.borderWidth = 4.f;
    self.imageView.layer.borderColor = borderColor;
}

- (void)viewDidAppear:(BOOL)animated {
    [self addLeaves];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    self.imageView = nil;
}

@end
