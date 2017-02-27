//
//  Module1ViewController.m
//  SFModularization
//
//  Created by 陈少华 on 2017/2/27.
//  Copyright © 2017年 sofach. All rights reserved.
//

#import "Module1ViewController.h"
#import "SFModularization.h"
#import "Module2Protocol.h"

@interface Module1ViewController ()

@end

@implementation Module1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"pushVC2" style:UIBarButtonItemStylePlain target:self action:@selector(pushVC2)];
    
    
    self.title = _text;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushVC2 {
    id<Module2Protocol> module2 = [[SFModularization sharedInstence] modulePerformsProtocol:@protocol(Module2Protocol)];
    UIViewController *vc2 = [module2 module2ViewControllerWithText:@"222222"];
    [self.navigationController pushViewController:vc2 animated:YES];
    
}

@end
