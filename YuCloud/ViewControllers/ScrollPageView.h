//
//  ScrollPageView.h
//  YuCloud
//
//  Created by 熊国锋 on 15/8/24.
//  Copyright (c) 2015年 VIROYAL-ELEC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScrollPageViewDelegate;

@interface ScrollPageView : UIView<UIScrollViewDelegate>
{
    UIView *firstView;
    UIView *middleView;
    UIView *lastView;
    
    UIGestureRecognizer     *tap;
    __unsafe_unretained id <ScrollPageViewDelegate>  _delegate;
    NSTimer         *autoScrollTimer;
}
@property (nonatomic,readonly)    UIScrollView *scrollView;
@property (nonatomic,readonly)  UIPageControl *pageControl;
@property (nonatomic,assign)    NSInteger currentPage;
@property (nonatomic,strong)    NSMutableArray *viewsArray;
@property (nonatomic,assign)    NSTimeInterval    autoScrollDelayTime;

@property (nonatomic,assign) id<ScrollPageViewDelegate> delegate;


-(void)shouldAutoShow:(BOOL)shouldStart;//自动滚动，界面不在的时候请调用这个停止timer

@end


@protocol ScrollPageViewDelegate <NSObject>

@optional
- (void)didClickPage:(ScrollPageView *)view atIndex:(NSInteger)index;

@end