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
#import "ModuleEvent.h"

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
    [[SFModularization sharedInstence] addListener:[self sharedInstence] toEvent:ModuleEvent];
}

- (UIViewController *)module2ViewControllerWithText:(NSString *)text {
    Module2ViewController *module2VC = [[Module2ViewController alloc] initWithNibName:nil bundle:nil];
    module2VC.text = text;
    
    return module2VC;
}

#pragma mark SFModuleProtocol
- (void)receiveEvent:(NSString *)event params:(NSDictionary *)params {
    NSLog(@"%@ receieve event:%@ params:%@", NSStringFromClass([self class]), event, params);
}

- (SFModulePriority)modulePriority {
    return SFModulePriorityHigh;
}

@end
