//
//  LJAiyukeViewController.m
//  LJSlideDemo
//
//  Created by 成都千锋 on 15/11/18.
//  Copyright (c) 2015年 成都千锋. All rights reserved.
//

#import "BallNewsViewController.h"

@interface BallNewsViewController (){
    NSArray *_subTitles;        //子视图标题
    NSArray *_controllers;      //子视图控制器
}

@end

@implementation BallNewsViewController

- (void)viewWillAppear:(BOOL)animated {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [defaults valueForKey:@"dict"];
    if (dict) {
        [self.titleBarView scrollViewIndex:[dict[@"set"] integerValue]];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1)];
    [self.view addSubview:lineView];
    self.titleBarView = [[TopTitleBarView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 44) addTitles:_subTitles];
    self.titleBarView.backgroundColor = [UIColor whiteColor];
    self.titleBarView.showsVerticalScrollIndicator = NO;
    self.titleBarView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.titleBarView];
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1)];
    [self.view addSubview:lineView1];
    self.honrizontalVC = [[HorizonalViewController alloc] initWithControllers:_controllers];
    self.honrizontalVC.view.frame = CGRectMake(0, 104, self.view.frame.size.width, self.view.frame.size.height - 104);
    [self addChildViewController:self.honrizontalVC];
    [self.view addSubview:self.honrizontalVC.view];
    
    //实现视图联动
    __weak typeof(self) weakSelf = self;
    self.titleBarView.block = ^(NSInteger index){
        [weakSelf.honrizontalVC scrollViewIndex:index];
    };
    self.honrizontalVC.block = ^(NSInteger index) {
        [weakSelf.titleBarView scrollViewIndex:index];
    };
}

- (instancetype)initWithSubTitles:(NSArray *)titles addControllers:(NSArray *)controllers {
    if (self = [super init]) {
        _subTitles = titles;
        _controllers = controllers;
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
