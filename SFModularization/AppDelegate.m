//
//  AppDelegate.m
//  SFModularization
//
//  Created by 陈少华 on 2017/2/27.
//  Copyright © 2017年 sofach. All rights reserved.
//

#import "AppDelegate.h"
#import "SFModularization.h"
#import "Module1Protocol.h"
#import "Module2Protocol.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [super application:application didFinishLaunchingWithOptions:launchOptions];
    
    id<Module1Protocol> module1 = [[SFModularization sharedInstence] modulePerformsProtocol:@protocol(Module1Protocol)];
    UIViewController *vc1 = [module1 module1ViewControllerWithText:@"111111"];
    UINavigationController *navi1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    navi1.tabBarItem = [UITabBarItem new];
    navi1.tabBarItem.title = @"vc1";
    
    id<Module2Protocol> module2 = [[SFModularization sharedInstence] modulePerformsProtocol:@protocol(Module2Protocol)];
    UIViewController *vc2 = [module2 module2ViewControllerWithText:@"222222"];
    UINavigationController *navi2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    navi2.tabBarItem = [UITabBarItem new];
    navi2.tabBarItem.title = @"vc2";
    
    UITabBarController *tab = [[UITabBarController alloc] init];
    [tab setViewControllers:@[navi1, navi2]];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = tab;
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
