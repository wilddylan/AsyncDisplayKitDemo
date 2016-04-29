//
//  AppDelegate.m
//  TimeLine
//
//  Created by Dylan on 16/4/28.
//  Copyright © 2016年 Dylan. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // start reveal request.
    [[NSNotificationCenter defaultCenter] postNotificationName:@"IBARevealRequestStart" object:nil];
    
    // test video URL
    
    return YES;
}

@end
