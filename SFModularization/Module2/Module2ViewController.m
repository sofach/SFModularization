//
//  Module2ViewController.m
//  SFModularization
//
//  Created by 陈少华 on 2017/2/27.
//  Copyright © 2017年 sofach. All rights reserved.
//

#import "Module2ViewController.h"
#import "SFModularization.h"
#import "Module1Protocol.h"
#import "ModuleEvent.h"

@interface Module2ViewController ()

@end

@implementation Module2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blueColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"pushVC1" style:UIBarButtonItemStylePlain target:self action:@selector(pushVC1)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"change title" style:UIBarButtonItemStylePlain target:self action:@selector(changeTitle)];
    
    self.title = _text;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)changeTitle {
    [[SFModularization sharedInstence] sendEvent:ModuleEvent params:@{@"param":@"value"}];
}

- (void)pushVC1 {
    id<Module1Protocol> module1 = [[SFModularization sharedInstence] moduleConformsToProtocol:@protocol(Module1Protocol)];
    UIViewController *vc1 = [module1 module1ViewControllerWithText:@"1111111"];
    vc1.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc1 animated:YES];
    
}

@end
