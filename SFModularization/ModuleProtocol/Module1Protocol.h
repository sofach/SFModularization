//
//  Module1Protocol.h
//  SFModularization
//
//  Created by 陈少华 on 2017/2/27.
//  Copyright © 2017年 sofach. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Module1Protocol <NSObject>

- (UIViewController *)module1ViewControllerWithText:(NSString *)text;

@end

