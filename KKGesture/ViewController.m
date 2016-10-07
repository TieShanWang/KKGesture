//
//  ViewController.m
//  KKGesture
//
//  Created by KING on 2016/10/7.
//  Copyright © 2016年 King. All rights reserved.
//

#import "ViewController.h"

#import "KKBaseComponent.h"

#import "KKGesture/KKGesture.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    KKGestureView * view = [[KKGestureView alloc]initWithFrame:CGRectMake(0, 100, KScreenWidth, KScreenWidth)];
    [self.view addSubview:view];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
