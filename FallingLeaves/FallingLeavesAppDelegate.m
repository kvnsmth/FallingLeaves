//
//  FallingLeavesAppDelegate.m
//  FallingLeaves
//
//  Created by Kevin Smith on 6/22/11.
//  Copyright 2011 Kevin Smith. All rights reserved.
//

#import "FallingLeavesAppDelegate.h"
#import "FallingLeavesViewController.h"

@implementation FallingLeavesAppDelegate {
	UIWindow *_window;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
	_window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	_window.backgroundColor = [UIColor blackColor];
	
	FallingLeavesViewController *fallingLeavesController = [[FallingLeavesViewController alloc] init];
    _window.rootViewController = fallingLeavesController;
	[fallingLeavesController release];
	
    [_window makeKeyAndVisible];
	
    return YES;
}

- (void)dealloc {
    [_window release];
    [super dealloc];
}

@end
