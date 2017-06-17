//
//  SFModule.m
//  SFModularization
//
//  Created by 陈少华 on 2017/6/17.
//  Copyright © 2017年 sofach. All rights reserved.
//

#import "SFModule.h"

@implementation SFModule

+ (instancetype)sharedInstence {
    return nil;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    SEL selector = [anInvocation selector];
    NSLog(@"[error] selector:[%@] not implement in module:%@ ", NSStringFromSelector(selector), self);
}

@end
