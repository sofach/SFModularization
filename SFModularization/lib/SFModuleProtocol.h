//
//  SFModuleProtocol.h
//  SFModularization
//
//  Created by 陈少华 on 2017/2/27.
//  Copyright © 2017年 sofach. All rights reserved.
//
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SFModulePriority) {
    SFModulePriorityDefault = 0,
    SFModulePriorityLow,
    SFModulePriorityHigh
};


@protocol SFModuleProtocol <UIApplicationDelegate>

+ (instancetype)sharedInstence;

@optional
- (NSString *)moduleName;
- (SFModulePriority)modulePriority;
- (void)receiveEvent:(NSString *)event params:(NSDictionary *)params;

//处理actionName
- (id)performAction:(NSString *)actionName params:(NSDictionary *)params;

//是否支持远程调用
- (id)canPerformRemoteAction:(NSString *)action params:(NSDictionary *)params;

@end
