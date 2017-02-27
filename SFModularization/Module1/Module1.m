//
//  Module1.m
//  SFModularization
//
//  Created by 陈少华 on 2017/2/27.
//  Copyright © 2017年 sofach. All rights reserved.
//

#import "Module1.h"
#import "SFModularization.h"
#import "Module1Protocol.h"
#import "Module1ViewController.h"

@implementation Module1

+ (instancetype)sharedInstence {
    static id sharedInstence = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstence = [[self alloc] init];
    });
    return sharedInstence;
}

+ (void)load {
    [[SFModularization sharedInstence] registerModule:[self sharedInstence] protocols:@[@protocol(Module1Protocol)]];
}

- (UIViewController *)module1ViewControllerWithText:(NSString *)text {
    Module1ViewController *module1VC = [[Module1ViewController alloc] initWithNibName:nil bundle:nil];
    module1VC.text = text;
    module1VC.tabBarItem = [UITabBarItem new];
    module1VC.tabBarItem.title = @"vc1";
    
    return module1VC;
}


@end
