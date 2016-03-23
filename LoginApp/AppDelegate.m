//
//  AppDelegate.m
//  LoginApp
//
//  Created by User on 3/16/16.
//  Copyright © 2016 Lilit Khachatryan. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [(UINavigationController *)self.window.rootViewController setNavigationBarHidden:YES animated:NO];
    
    return YES;
}

@end
