//
//  SFModularization.h
//  SFModularization
//
//  Created by 陈少华 on 2017/2/27.
//  Copyright © 2017年 sofach. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFModuleProtocol.h"
#import "SFAppDelegate.h"

@interface SFModularization : NSObject

+ (instancetype)sharedInstence;

- (void)enumerateModules:(void(^)(id<SFModuleProtocol>))block;

- (BOOL)registerModule:(id<SFModuleProtocol>)module protocols:(NSArray<Protocol *> *)protocols;

- (id)moduleConformsToProtocol:(Protocol *)protocol;

- (void)addListener:(id<SFModuleProtocol>)module toEvent:(NSString *)event;
- (void)removeListener:(id<SFModuleProtocol>)module toEvent:(NSString *)event;
- (void)removeAllListenersToEvent:(NSString *)event;
- (void)sendEvent:(NSString *)event params:(NSDictionary *)params;

- (id)performAction:(NSString *)actionName toModuleNamed:(NSString *)moduleName params:(NSDictionary *)params;
- (id)performAction:(NSString *)actionName toModuleNamed:(NSString *)moduleName params:(NSDictionary *)params isRemote:(BOOL)isRemote;

@end
