//
//  AppDelegate.m
//  List
//
//  Created by Michael McChesney on 1/7/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

#import "AppDelegate.h"
#import "ListTVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

//  GOOD STUFF ON HOW TO DECLARE TABLEVIEWCONTROLLERS WITHOUT STORYBOARD

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
//    Here we will add a table view controller as the rootViewController.
//    UITableViewController * rootTVC = [[UITableViewController alloc] init];
//    self.window.rootViewController = rootTVC;
    
    self.window.rootViewController = [[ListTVC alloc] init];
//    ^ This is the same thing as setting it to rootTVC but only takes one line.
    
//    self.window.rootViewController.view.backgroundColor = [UIColor blackColor];
//    ^ This is how you could change the background color of the view.
    
    [self.window makeKeyAndVisible];
    

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
