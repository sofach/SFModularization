//
//  SFModularization.m
//  SFModularization
//
//  Created by 陈少华 on 2017/2/27.
//  Copyright © 2017年 sofach. All rights reserved.
//

#import "SFModularization.h"

@interface SFModularization ()

@property (strong, nonatomic) NSMutableArray *modules;

@property (strong, nonatomic) NSMutableDictionary *nameModuleMap;

@property (strong, nonatomic) NSMutableDictionary *protocolModuleMap;

@property (strong, nonatomic) NSMutableDictionary *eventModulesMap;

@end

@implementation SFModularization

+ (instancetype)sharedInstence {
    static id sharedInstence = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstence = [[self alloc] init];
    });
    return sharedInstence;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _modules = [NSMutableArray arrayWithCapacity:5];
        _nameModuleMap = [NSMutableDictionary dictionary];
        _protocolModuleMap = [NSMutableDictionary dictionary];
        _eventModulesMap = [NSMutableDictionary dictionary];
    }
    return self;
}

- (id)performSelector:(SEL)aSelector target:(id)target action:(NSString *)action params:(NSDictionary *)params {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    return [target performSelector:aSelector withObject:action withObject:params];
#pragma clang diagnostic pop
}

- (id<SFModuleProtocol>)moduleNamed:(NSString *)moduleName {
    if (!moduleName) {
        return nil;
    }
    id<SFModuleProtocol> module = [self.nameModuleMap objectForKey:moduleName];
    
    return module;
}

- (void)addModule:(id<SFModuleProtocol>)module intoArray:(NSMutableArray *)array {
    SFModulePriority priority = SFModulePriorityDefault;
    if ([module respondsToSelector:@selector(modulePriority)]) {
        priority = [module modulePriority];
    }
    if (priority==SFModulePriorityHigh) {
        [array insertObject:module atIndex:0];
    } else if (priority==SFModulePriorityHigh) {
        [array addObject:module];
    } else {
        [array addObject:module];
    }
}


#pragma mark - public method
- (void)enumerateModules:(void(^)(id<SFModuleProtocol>))block {
    if (!block) {
        return;
    }
    [_modules enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        block(obj);
    }];
}

- (BOOL)registerModule:(id<SFModuleProtocol>)module protocols:(NSArray<Protocol *> *)protocols {
    
    if (!module) {
        NSLog(@"[warn] register module, module can't be nil");
        return NO;
    }
    NSString *moduleName = nil;
    if ([module respondsToSelector:@selector(moduleName)]) {
        moduleName = [module moduleName];
    } else {
        moduleName = NSStringFromClass([module class]);
    }
    if ([self.nameModuleMap objectForKey:moduleName]) {
        NSLog(@"[warn] register module name:%@, already exist:%@", moduleName, [self.nameModuleMap objectForKey:moduleName]);
        return NO;
    }
    [self.nameModuleMap setObject:module forKey:moduleName];

    [protocols enumerateObjectsUsingBlock:^(Protocol * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSString *protocolName = NSStringFromProtocol(obj);
        id premodule = [_protocolModuleMap objectForKey:protocolName];
        if (premodule) {
            NSLog(@"[warn] register protocol%@, already exist:%@", protocolName, premodule);
        } else {
            [_protocolModuleMap setObject:module forKey:protocolName];
        }
    }];
    [self addModule:module intoArray:self.modules];
    
    return YES;
}


- (void)addListener:(id<SFModuleProtocol>)module toEvent:(NSString *)event {
    if (!event || !module) {
        NSLog(@"[warn] add listener, module or event can't be nil");
        return;
    }
    NSMutableArray *modules = [_eventModulesMap objectForKey:event];
    if (!modules) {
        modules = [NSMutableArray array];
    }
    [self addModule:module intoArray:modules];
    
    [_eventModulesMap setObject:modules forKey:event];
}

- (void)removeListener:(id<SFModuleProtocol>)module toEvent:(NSString *)event {
    NSMutableArray *modules = [_eventModulesMap objectForKey:event];
    [modules removeObject:module];
}

- (void)removeAllListenersToEvent:(NSString *)event {
    [_eventModulesMap removeObjectForKey:event];
}

- (id)moduleConformsToProtocol:(Protocol *)protocol {
    if (!protocol) {
        NSLog(@"[warn] get module from protocol, protocol can't be nil");
        return nil;
    }
    NSString *protocolName = NSStringFromProtocol(protocol);
    
    return [_protocolModuleMap objectForKey:protocolName];
}

- (void)sendEvent:(NSString *)event params:(NSDictionary *)params {
    NSMutableArray<id<SFModuleProtocol>> *modules = [_eventModulesMap objectForKey:event];
    [modules enumerateObjectsUsingBlock:^(id<SFModuleProtocol>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj respondsToSelector:@selector(receiveEvent:params:)]) {
            [obj receiveEvent:event params:params];
        }
    }];
}



- (id)performAction:(NSString *)actionName toModuleNamed:(NSString *)moduleName params:(NSDictionary *)params {
    return [self performAction:actionName toModuleNamed:moduleName params:params isRemote:NO];
}

- (id)performAction:(NSString *)actionName toModuleNamed:(NSString *)moduleName params:(NSDictionary *)params isRemote:(BOOL)isRemote {
    
    if (!moduleName || !actionName) {
        NSLog(@"[warn] performAction:%@ toModuleNamed:%@, params can't be nil", actionName, moduleName);
        return nil;
    }
    
    id module = [self moduleNamed:moduleName];
    if (!module) {
        NSLog(@"[error] module named:%@ not found", moduleName);
        return nil;
    }
    
    //远程调用，需要先验证这个action是否支持远程调用
    if (isRemote) {
        
        SEL canPerformSelector = NSSelectorFromString(@"canPerformRemoteAction:params:");
        if (![module respondsToSelector:canPerformSelector] || ![[self performSelector:canPerformSelector target:module action:actionName params:params] boolValue]) {
            
            NSLog(@"[error] module:%@ can't perform remote action:%@", module, actionName);
            return nil;
        }
    }
    
    SEL selector = NSSelectorFromString(@"performAction:params:");
    if ([module respondsToSelector:selector]) {
        
        return [self performSelector:selector target:module action:actionName params:params];
    } else {
        NSLog(@"[warn] module：%@ not implements performAction:", module);
        return nil;
    }
}

@end
