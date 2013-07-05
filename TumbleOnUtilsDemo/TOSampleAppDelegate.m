//
//  AppDelegate.m
//  TumbleOnUtils
//
//  Created by Jason Baker on 7/2/13.
//  Copyright (c) 2013 Jason Baker. All rights reserved.
//

#import "TOSampleAppDelegate.h"
#import "TOSampleViewController.h"

@interface TOSampleAppDelegate ()
@property (nonatomic, strong) UINavigationController * navigationController;
@end

@implementation TOSampleAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    TOSampleViewController * vc = [[TOSampleViewController alloc] init];
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {}
- (void)applicationDidEnterBackground:(UIApplication *)application {}
- (void)applicationWillEnterForeground:(UIApplication *)application {}
- (void)applicationDidBecomeActive:(UIApplication *)application {}
- (void)applicationWillTerminate:(UIApplication *)application {}

@end
