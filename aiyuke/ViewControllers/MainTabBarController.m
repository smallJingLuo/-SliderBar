//
//  MainTabBarController.m
//  aiyuke
//
//  Created by 成都千锋 on 15/11/19.
//  Copyright (c) 2015年 成都千锋. All rights reserved.
//

#import "MainTabBarController.h"
#import "RootHorizonalViewController.h"
#import "BallNewsViewController.h"
#import "MineViewController.h"
#import "CicrleViewController.h"
#import "PlayBallViewController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    NSArray *subTitles= @[@"头条",@"视频",@"赛事",@"教学",@"更多"];
    NSArray *controllerStrings = @[@"HeaderViewController",@"VideoViewController",@"GameViewController",@"TeachingViewController",@"MoreViewController"];
    NSMutableArray *controllers = [NSMutableArray array];
    for (NSString *str in controllerStrings) {
        Class class = NSClassFromString(str);
        RootHorizonalViewController *rootVC = [[class alloc] init];
        CGFloat R = arc4random() % 255 / 256.0;
        CGFloat G = arc4random() % 255 / 256.0;
        CGFloat B = arc4random() % 255 / 256.0;
        rootVC.view.backgroundColor = [UIColor colorWithRed:R green:G blue:B alpha:1];
        [controllers addObject:rootVC];
    }
//    NSArray *BarTitles = @[@"",@"",@"",@""];
//    NSArray *barControllerString = @[@"",@"",@"",@""];
//    NSMutableArray *barControllers = [NSMutableArray array];
    BallNewsViewController *ballNewsVC = [[BallNewsViewController alloc] initWithSubTitles:subTitles addControllers:controllers];
    [ballNewsVC addTitle:@"球讯"];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:ballNewsVC];
    PlayBallViewController *playVC = [[PlayBallViewController alloc] init];
    [playVC addTitle:@"打球"];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:playVC];
    MineViewController *mineVC = [[MineViewController alloc] init];
    [mineVC addTitle:@"圈子"];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:mineVC];
    CicrleViewController *cicrleVC = [[CicrleViewController alloc] init];
    [cicrleVC addTitle:@"我的"];
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:cicrleVC];
    self.viewControllers = @[nav1,nav2,nav3,nav4];
    
     NSArray *itemName = @[@"球讯",@"打球",@"圈子",@"我的"];
    //NSArray *itemImage = @[@"",@"",@"",@""];
    [self.tabBar.items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UITabBarItem *item = (id)obj;
        item.title = itemName[idx];
//        item.image = [UIImage imageNamed:itemImage[idx]];
//        item.selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@-selected",itemImage[idx]]];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
