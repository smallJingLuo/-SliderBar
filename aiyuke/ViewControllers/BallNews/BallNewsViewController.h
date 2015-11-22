//
//  BallNewsViewController.h
//  aiyuke
//
//  Created by 成都千锋 on 15/11/19.
//  Copyright (c) 2015年 成都千锋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChildrenBaseViewController.h"
#import "HorizonalViewController.h"
#import "TopTitleBarView.h"

@interface BallNewsViewController : ChildrenBaseViewController

/**子标题视图*/
@property (nonatomic, strong) TopTitleBarView *titleBarView;

/**子视图控制器的承载控制器*/
@property (nonatomic, strong) HorizonalViewController *honrizontalVC;

/*!
 @brief 初始化方法
 @param titles  子视图控制器的title
 @param ViewControllers 子视图控制器
 */
- (instancetype)initWithSubTitles:(NSArray *)titles addControllers:(NSArray *)controllers;

@end
