//
//  HorizonalViewController.h
//  aiyuke
//
//  Created by 成都千锋 on 15/11/19.
//  Copyright (c) 2015年 成都千锋. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^scrollViewblock)(NSInteger);

@interface HorizonalViewController : UIViewController

/**scrollView滚动回调的block*/
@property (nonatomic, copy) scrollViewblock block;

/*!
 @brief 当点击按钮后的scrollView随之滚动的回调方法
 @param  按钮下标
 */
- (void) scrollViewIndex:(NSInteger)index;

/*!
 @brief 初始化方法
 @param 控制器数组
 */
- (instancetype)initWithControllers:(NSArray *)controllers;

@end
