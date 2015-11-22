//
//  LJTitleBarView.m
//  FitnessHelper
//
//  Created by 成都千锋 on 15/10/29.
//  Copyright (c) 2015年 成都千锋. All rights reserved.
//

#import "TopTitleBarView.h"

#define BUTTON_WIDTH 100  //button宽度
#define BUTTON_GAP_F_B 20//button两边空白距离

#define BUTTON_BEGIN_TAG 100 //button的tag开始值

@implementation TopTitleBarView{
    NSArray *_titlesArray;//保存标题数组
    NSMutableArray *_titleButtonArray;//保存按钮
    NSInteger _currentButton;//当前按钮
    UILabel *_label;
    BOOL _isLast;  //解决bugBOLL值
}

- (instancetype)initWithFrame:(CGRect)frame addTitles:(NSArray *)titles {
    if (self = [super initWithFrame:frame]) {
        _titlesArray = titles;
        CGSize size = [_titlesArray[0] boundingRectWithSize:CGSizeMake(0, self.frame.size.height - 8) options:0 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:24]} context:nil].size;
        self.contentSize = CGSizeMake((size.width + 40) * _titlesArray.count, self.frame.size.height);
        [self setupUI];
    }
    return self;
}

//创建UI
- (void) setupUI {
    _titleButtonArray = [NSMutableArray array];
    //根据button的个数计算scrollSize
    CGSize scrollSize = CGSizeMake((BUTTON_WIDTH *_titlesArray.count > self.frame.size.width) ? BUTTON_WIDTH * _titlesArray.count : self.frame.size.width , self.frame.size.height);
    self.contentSize = scrollSize;
    
    
    CGFloat buttonHeight = self.frame.size.height - 8;
    for (int i = 0; i < _titlesArray.count; i ++) {
        CGSize size = [_titlesArray[i] boundingRectWithSize:CGSizeMake(0, buttonHeight) options:0 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:24]} context:nil].size;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i * (size.width + 40), 0, (size.width + 40), buttonHeight);
        [button setTitle:_titlesArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(scrollButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = BUTTON_BEGIN_TAG + i;
        [self addSubview:button];
        [_titleButtonArray addObject:button];
    }
    
    _currentButton = BUTTON_BEGIN_TAG;
    UIButton *button = _titleButtonArray[_currentButton - BUTTON_BEGIN_TAG];
    button.selected = YES;
    button.transform = CGAffineTransformMakeScale(1.2, 1.2);
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, buttonHeight, 88, 8)];
    _label.backgroundColor = [UIColor redColor];
    _label.layer.cornerRadius = 2;
    _label.layer.masksToBounds = YES;
    [self addSubview:_label];
    self.contentSize = CGSizeMake(button.frame.size.width * _titlesArray.count, self.frame.size.height);
}

- (void) scrollButtonClicked:(UIButton *)sender {
    CGRect rect = CGRectMake((sender.tag - BUTTON_BEGIN_TAG) * 88, self.frame.size.height - 8, 88, 8);
    [UIView animateWithDuration:0.2 animations:^{
        if (sender.tag - BUTTON_BEGIN_TAG == _titlesArray.count - 1) {
            
        }else {
            _isLast = NO;
        }
        if (!_isLast) {
            
            _label.frame = rect;
        }
        if (sender.tag - BUTTON_BEGIN_TAG == _titlesArray.count - 1) {
            _isLast = YES;
        }else {
        
        }
    }];
    if (_currentButton != sender.tag) {
        sender.transform = CGAffineTransformMakeScale(1.2, 1.2);
        sender.selected = YES;
        UIButton *button = _titleButtonArray[_currentButton - BUTTON_BEGIN_TAG];
        button.selected = NO;
        button.transform = CGAffineTransformIdentity;
        
        
    }
    NSInteger index = [_titleButtonArray indexOfObject:sender];
   
    if (index == 0 || index == _titlesArray.count - 2 || index == _titlesArray.count - 1) {
        if (index == 0) {
            UIButton *preBtn = _titleButtonArray[index];
            float offsetX = CGRectGetMinX(preBtn.frame);
            [self setContentOffset:CGPointMake(offsetX + 9, 0) animated:YES];
        }
        if (index == _titlesArray.count - 1) {
            UIButton *preBtn = _titleButtonArray[index - 3];
            float offsetX = CGRectGetMinX(preBtn.frame);
            [self setContentOffset:CGPointMake(offsetX - 23, 0) animated:YES];
        }
        if ( index == _titlesArray.count - 2) {
            UIButton *preBtn = _titleButtonArray[index - 2];
            float offsetX = CGRectGetMinX(preBtn.frame);
            [self setContentOffset:CGPointMake(offsetX  - 23, 0) animated:YES];
        }
        
    }else {
        UIButton *preBtn = _titleButtonArray[index - 1];
        float offsetX = CGRectGetMinX(preBtn.frame);
        if (preBtn.tag - BUTTON_BEGIN_TAG == 0) {
            [self setContentOffset:CGPointMake(offsetX, 0) animated:YES];
        }else {
            [self setContentOffset:CGPointMake(offsetX - 23, 0) animated:YES];
        }
    }
    
    _currentButton = sender.tag;
    if (self.block) {
        self.block(_currentButton - BUTTON_BEGIN_TAG);
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger idx = sender.tag - BUTTON_BEGIN_TAG;
    NSDictionary *dict = @{@"set":[@(idx) stringValue]};
    [defaults setValue:dict forKey:@"dict"];
    
}


- (void)scrollViewIndex:(NSInteger)index {
    UIButton *button = (UIButton *)[self viewWithTag:index + BUTTON_BEGIN_TAG];
    if (button) {
        [self scrollButtonClicked:button];
    }
}






@end
