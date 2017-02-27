//
//  SFModuleProtocol.h
//  SFModularization
//
//  Created by 陈少华 on 2017/2/27.
//  Copyright © 2017年 sofach. All rights reserved.
//

@protocol SFModuleProtocol <UIApplicationDelegate>

+ (instancetype)sharedInstence;

@optional
- (NSString *)moduleName;

//处理actionName
- (id)performAction:(NSString *)actionName params:(NSDictionary *)params;

//是否支持远程调用
- (id)canPerformRemoteAction:(NSString *)action params:(NSDictionary *)params;

@end
