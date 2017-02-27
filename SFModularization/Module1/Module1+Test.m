//
//  Module1+Test.m
//  SFModularization
//
//  Created by 陈少华 on 2017/2/27.
//  Copyright © 2017年 sofach. All rights reserved.
//

#import "Module1+Test.h"
#import "Module1ViewController.h"

@implementation Module1 (Test)

- (UIViewController *)module1ViewControllerWithText:(NSString *)text {
    Module1ViewController *module1VC = [[Module1ViewController alloc] initWithNibName:nil bundle:nil];
    module1VC.text = text;
    module1VC.tabBarItem = [UITabBarItem new];
    module1VC.tabBarItem.title = @"vc1";
    
    return module1VC;
}
@end
