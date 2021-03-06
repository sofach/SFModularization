//
//  Module1.m
//  SFModularization
//
//  Created by 陈少华 on 2017/2/27.
//  Copyright © 2017年 sofach. All rights reserved.
//

#import "Module1.h"
#import "SFModularization.h"
#import "Module1+Test.h"
#import "ModuleEvent.h"

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
    [[SFModularization sharedInstence] addListener:[self sharedInstence] toEvent:ModuleEvent];
}

- (void)receiveEvent:(NSString *)event params:(NSDictionary *)params {
    NSLog(@"%@ receieve event:%@ params:%@", NSStringFromClass([self class]), event, params);
}
@end
