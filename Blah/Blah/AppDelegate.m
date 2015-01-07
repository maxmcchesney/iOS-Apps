//
//  AppDelegate.m
//  Blah
//
//  Created by Michael McChesney on 1/5/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
//  Never import .m files, only headers.

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    int number1 = 2;
    int number2 = 3;
    
    int value = number1 + number2;
    NSLog(@"Value is %d\n", value);
    
    NSString * name = @"Max";
    NSLog(@"Name is %@\n", name);
    
    NSNumber * number = @5;
    NSLog(@"%@",number);
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//  THE CODE BELOW is setting up a view controller and window using code rather than the storyboard.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//   ^ This has to be first, you have to have the creation of an object before you set up the rest or interact with it. Everything below can be in any order.
    
//    ViewController * mainVC = [[ViewController alloc] init];
//    
//    mainVC.name = @"NAME";
//    
//    self.window.rootViewController = mainVC;
//    
//    mainVC.view.backgroundColor = [UIColor blueColor];
    
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
   
//    @"text" is an instance object
//    [@"text" stringByAppendingString:@"text2"]
    
//    ViewController *viewController = [storyboard instantiateInitialViewController];
    
    ViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"mainVC"];
    
    self.window.rootViewController = viewController;
    
    self.window.backgroundColor = [UIColor greenColor];
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
