//
//  WelcomeScrollPageView.h
//  YuCloud
//
//  Created by 熊国锋 on 15/8/24.
//  Copyright (c) 2015年 VIROYAL-ELEC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WelcomeScrollPageViewDelegate;

@interface WelcomeScrollPageView : UIView<UIScrollViewDelegate>
{
    UIView  *firstView;
    UIView  *middleView;
    UIView  *lastView;
    
    UIGestureRecognizer                                 *tap;
    __unsafe_unretained id <WelcomeScrollPageViewDelegate>     _delegate;
    NSTimer                                             *autoScrollTimer;
}
@property (nonatomic,readonly)      UIScrollView        *scrollView;
@property (nonatomic,readonly)      UIPageControl       *pageControl;
@property (nonatomic,assign)        NSInteger           currentPage;
@property (nonatomic,strong)        NSMutableArray      *viewsArray;
@property (nonatomic,strong)        NSMutableArray      *imageArray;
@property (nonatomic,assign)        NSTimeInterval      autoScrollDelayTime;
@property (nonatomic,assign)        BOOL                shouldAutoScroll;

@property (nonatomic,assign) id <WelcomeScrollPageViewDelegate> delegate;


-(void)shouldAutoShow:(BOOL)shouldStart;//自动滚动，界面不在的时候请调用这个停止timer

@end


@protocol WelcomeScrollPageViewDelegate <NSObject>

@optional
- (void)didClickPage:(WelcomeScrollPageView *)view atIndex:(NSInteger)index;

@end


