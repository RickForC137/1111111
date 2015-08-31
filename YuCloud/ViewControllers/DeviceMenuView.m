//
//  DeviceMenuView.m
//  YuCloud
//
//  Created by 熊国锋 on 15/8/28.
//  Copyright (c) 2015年 VIROYAL-ELEC. All rights reserved.
//

#import "DeviceMenuView.h"


@interface DeviceMenuView ()

@property (nonatomic, readonly)     MenuPageView                      *firstView;
@property (nonatomic, readonly)     MenuPageView                      *secondView;

@end

typedef NS_ENUM(NSInteger, CustomColorType)
{
    CustomColorTypeBackground = 0,
    CustomColorTypeSep,
    
    //add new items before this item
    CustomColorTypeCount
};

@implementation MenuItem


- (instancetype)initWithName:(NSString *)title action:(SEL)action
{
    self = [super init];
    
    _title = title;
    _action = action;
    
    return self;
}

@end

@implementation MenuPageView

- (void)setArrMenuItems:(NSMutableArray *)arr
{
    CGRect rectMain = self.bounds;
    rectMain.origin.x += rectMain.size.height;
    rectMain.size.width -= rectMain.size.height;
    
    NSUInteger count = arr.count;
    NSUInteger width = rectMain.size.width / count;
    for (MenuItem *item in arr)
    {
        CGRect rect = rectMain;
        rect.size.width = width;
        item.rect = rect;
        
        if(item.title)
        {
            UILabel *label = [[UILabel alloc] initWithFrame:rect];
            label.text = item.title;
            label.textColor = [UIColor whiteColor];
            label.font = GetFontWithType(FontTypeDeviceMenuLabel);
            label.textAlignment = NSTextAlignmentCenter;
            
            [self addSubview:label];
        }
        else if(item.image)
        {
            
        }
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = rect;
        btn.backgroundColor = [UIColor clearColor];
        [btn addTarget:self.delegate action:item.action forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btn];
        
        //then the left region
        rectMain.origin.x += width;
        rectMain.size.width -= width;
    }
    
    _arrMenuItems = arr;
}

@end

@implementation DeviceMenuView

- (UIColor *)getCustomColor:(CustomColorType)type
{
    switch (type)
    {
        case CustomColorTypeBackground:
            return [UIColor lightGrayColor];
        case CustomColorTypeSep:
            return [UIColor darkGrayColor];
        case CustomColorTypeCount:
            break;
    }
    return [UIColor redColor];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    self.backgroundColor = [self getCustomColor:CustomColorTypeBackground];
    
    //init the page button
    
    return self;
}

- (void)initPageButton:(UIView *)view image:(UIImage *)image rect:(CGRect)rectBtn
{
    UIView *iconView = [[UIView alloc] initWithFrame:rectBtn];
    UIImageView *iconImageView = [[UIImageView alloc] initWithImage:image];
    iconImageView.center = iconView.center;
    
    [iconView addSubview:iconImageView];
    [view addSubview:iconView];
    
    //then the line
    CGRect rectLine = rectBtn;
    rectLine.origin.x = rectLine.origin.x + rectLine.size.width - 1;
    rectLine.size.width = 1;
    UIView *viewLine = [[UIView alloc] initWithFrame:rectLine];
    viewLine.backgroundColor = [self getCustomColor:CustomColorTypeSep];
    [view addSubview:viewLine];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = rectBtn;
    btn.backgroundColor = [UIColor clearColor];
    [btn addTarget:self action:@selector(pageButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
}

- (void)pageButtonPressed
{
    [self switchPageViews:YES];
}

- (void)onActionInteraction
{
    if(_delegate && [_delegate respondsToSelector:@selector(onActionInteraction)])
    {
        [_delegate performSelector:@selector(onActionInteraction)];
    }
}

- (void)onActionWarning
{
    if(_delegate && [_delegate respondsToSelector:@selector(onActionWarning)])
    {
        [_delegate performSelector:@selector(onActionWarning)];
    }
}

- (void)onActionSettings
{
    if(_delegate && [_delegate respondsToSelector:@selector(onActionSettings)])
    {
        [_delegate performSelector:@selector(onActionSettings)];
    }
}

- (void)initFirstPage
{
    NSMutableArray *arr = [[NSMutableArray alloc] initWithObjects:nil];
    
    MenuItem *item;
    item = [[MenuItem alloc] initWithName:@"互动" action:@selector(onActionInteraction)];
    [arr addObject:item];
    
    item = [[MenuItem alloc] initWithName:@"告警" action:@selector(onActionWarning)];
    [arr addObject:item];
    
    item = [[MenuItem alloc] initWithName:@"设置" action:@selector(onActionSettings)];
    [arr addObject:item];
    
    [_firstView setArrMenuItems:arr];
}

- (void)initSecondPage
{
    
}

- (void)initDeviceMenu
{
    CGRect rectMain = self.bounds;
    CGRect rectIcon = rectMain;
    rectIcon.size.width = rectIcon.size.height;
    
    //first page is the main menu
    _firstView = [[MenuPageView alloc] initWithFrame:rectMain];
    rectMain.origin.y += rectMain.size.height;
    _secondView = [[MenuPageView alloc] initWithFrame:rectMain];
    
    _firstView.delegate = self;
    _secondView.delegate = self;
    
    [self initPageButton:_firstView image:[UIImage imageNamed:@"menu"] rect:rectIcon];
    [self initPageButton:_secondView image:[UIImage imageNamed:@"device-menu2"] rect:rectIcon];
    
    [self initFirstPage];
    [self initSecondPage];
    
    [self addSubview:_firstView];
    [self addSubview:_secondView];
}

- (void)switchPageViews:(BOOL)animated
{
    UIView *currentView, *nextView;
    CGRect rectMain = self.bounds;
    if(_firstView.center.y < rectMain.size.height)
    {
        currentView = _firstView;
        nextView = _secondView;
    }
    else
    {
        currentView = _secondView;
        nextView = _firstView;
    }
    
    //first hide the current view
    [UIView animateWithDuration:0.3f animations:^
    {
        currentView.center = CGPointMake(currentView.center.x, currentView.center.y + rectMain.size.height);
    }
    completion:^(BOOL finished)
    {
        currentView.hidden = YES;
        nextView.hidden = NO;
        
        CGRect rect = self.bounds;
        rect.origin.y = rect.size.height;
        nextView.frame = rect;
        [UIView animateWithDuration:0.8f animations:^{
            nextView.center = CGPointMake(nextView.center.x, rect.size.height / 2.0);
        }completion:^(BOOL finished){}];
    }];
    
}

@end



