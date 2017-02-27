//
//  Module2.m
//  SFModularization
//
//  Created by 陈少华 on 2017/2/27.
//  Copyright © 2017年 sofach. All rights reserved.
//

#import "Module2.h"
#import "SFModularization.h"
#import "Module2ViewController.h"

@implementation Module2

+ (instancetype)sharedInstence {
    static id sharedInstence = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstence = [[self alloc] init];
    });
    return sharedInstence;
}

+ (void)load {
    [[SFModularization sharedInstence] registerModule:[self sharedInstence] protocols:@[@protocol(Module2Protocol)]];
}

- (UIViewController *)module2ViewControllerWithText:(NSString *)text {
    Module2ViewController *module2VC = [[Module2ViewController alloc] initWithNibName:nil bundle:nil];
    module2VC.text = text;
    
    return module2VC;
}

@end
