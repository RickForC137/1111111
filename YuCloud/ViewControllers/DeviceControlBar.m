//
//  DeviceControlBar.m
//  YuCloud
//
//  Created by 熊国锋 on 15/8/28.
//  Copyright (c) 2015年 VIROYAL-ELEC. All rights reserved.
//

#import "DeviceControlBar.h"
#import "PushToTalkButton.h"


@interface DeviceControlBar ()

@property (nonatomic, readonly)     MenuPageView                      *firstView;
@property (nonatomic, readonly)     MenuPageView                      *secondView;

@end

#define SHOWS_TOUCH_WHEN_HIGHLIGHTED  YES

typedef NS_ENUM(NSInteger, CustomColorType)
{
    CustomColorTypeBackground = 0,
    CustomColorTypeSep,
    CustomColorTypeBorder,
    CustomColorTypeTitle,
    
    //add new items before this item
    CustomColorTypeCount
};

UIColor *getCustomColor(CustomColorType type)
{
    switch (type)
    {
        case CustomColorTypeBackground:
            return [UIColor darkGrayColor];
        case CustomColorTypeSep:
            return [UIColor lightGrayColor];
        case CustomColorTypeBorder:
            return [UIColor lightGrayColor];
        case CustomColorTypeTitle:
            return [UIColor whiteColor];
        case CustomColorTypeCount:
            break;
    }
    return [UIColor redColor];
}

@implementation MenuItem


- (instancetype)init
{
    self = [super init];
    _alignment = NSTextAlignmentLeft;
    _bPushToTalk = NO;
    
    return self;
}

- (instancetype)initWithName:(NSString *)title action:(SEL)action
{
    self = [super init];
    
    _title = title;
    _action = action;
    
    return self;
}

- (instancetype)initWithName:(NSString *)title action:(SEL)action bTalk:(BOOL)bTalk
{
    self = [super init];
    
    _title = title;
    _action = action;
    _bPushToTalk = bTalk;
    
    return self;
}

- (instancetype)initWithImage:(UIImage *)image action:(SEL)action
{
    self = [super init];
    
    _image = image;
    _action = action;
    
    return self;
}

- (instancetype)initWithImage:(UIImage *)image action:(SEL)action alignment:(NSTextAlignment)alignment
{
    self = [super init];
    
    _image = image;
    _action = action;
    _alignment = alignment;
    
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
    BOOL bMixed = NO;
    for (MenuItem *item in arr)
    {
        CGRect rect = rectMain;
        rect.size.width = width;
        if(item.image)
        {
            rect.size.width = rect.size.height;
            bMixed = YES;
        }
        if(item.alignment == NSTextAlignmentRight)
        {
            rect.origin.x = rectMain.origin.x + rectMain.size.width - rect.size.width;
        }
        item.rect = rect;
        
        if(item.bPushToTalk)
        {
            if(bMixed)
            {
                //有图片也有文字，这个文字就当是最后一个元素
                item.rect = rectMain;
            }
            CGRect rectBtn = item.rect;
            rectBtn = CGRectInset(rectBtn, 2, 2);
            _pushToTalkBtn = [PushToTalkButton buttonWithType:UIButtonTypeCustom];
            [_pushToTalkBtn setTitleColor:getCustomColor(CustomColorTypeTitle) forState:UIControlStateNormal];
            [_pushToTalkBtn setFrame:rectBtn];
            [_pushToTalkBtn setPushState:PushButtonStateNormal];
            
            _pushToTalkBtn.layer.cornerRadius = 8;
            _pushToTalkBtn.layer.borderWidth = 1;
            _pushToTalkBtn.layer.borderColor = [getCustomColor(CustomColorTypeBorder) CGColor];
            _pushToTalkBtn.layer.masksToBounds = YES;
            
            [_pushToTalkBtn addTarget:self action:@selector(pushToTalkTouchDown)        forControlEvents:UIControlEventTouchDown];
            [_pushToTalkBtn addTarget:self action:@selector(pushToTalkTouchUpInside)    forControlEvents:UIControlEventTouchUpInside];
            [_pushToTalkBtn addTarget:self action:@selector(pushToTalkTouchUpOutside)   forControlEvents:UIControlEventTouchUpOutside];
            [_pushToTalkBtn addTarget:self action:@selector(pushToTalkTouchDragEnter)   forControlEvents:UIControlEventTouchDragEnter];
            [_pushToTalkBtn addTarget:self action:@selector(pushToTalkTouchDragExit)    forControlEvents:UIControlEventTouchDragExit];
            
            [self addSubview:_pushToTalkBtn];
        }
        else if(item.title)
        {
            if(bMixed)
            {
                item.rect = rectMain;
            }
            
            CGRect rectBtn = item.rect;
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:item.title forState:UIControlStateNormal];
            [btn setTitleColor:getCustomColor(CustomColorTypeTitle) forState:UIControlStateNormal];
            [btn setShowsTouchWhenHighlighted:SHOWS_TOUCH_WHEN_HIGHLIGHTED];
            [btn setFrame:rectBtn];
            
            [btn addTarget:self.delegate action:item.action forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            
            //then the line, make sure this is not the last element
            if(rectMain.size.width - rectBtn.size.width > 10)
            {
                CGRect rectLine = rectBtn;
                rectLine.origin.x = rectLine.origin.x + rectLine.size.width - 1;
                rectLine.size.width = 1;
                UIView *viewLine = [[UIView alloc] initWithFrame:rectLine];
                viewLine.backgroundColor = getCustomColor(CustomColorTypeSep);
                [self addSubview:viewLine];
            }
        }
        else if(item.image)
        {
            CGRect rectBtn = item.rect;
            rectBtn = CGRectInset(rectBtn, 2, 2);
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setImage:item.image forState:UIControlStateNormal];
            [btn setShowsTouchWhenHighlighted:SHOWS_TOUCH_WHEN_HIGHLIGHTED];
            btn.frame = rectBtn;
            
            btn.layer.cornerRadius = item.rect.size.width / 2.0;
            btn.layer.borderWidth = 1;
            btn.layer.borderColor = [getCustomColor(CustomColorTypeBorder) CGColor];
            btn.layer.masksToBounds = YES;
            
            [btn addTarget:self.delegate action:item.action forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
        }
        
        //then the left region
        if(item.alignment != NSTextAlignmentRight)
        {
            rectMain.origin.x += item.rect.size.width;
        }
        
        rectMain.size.width -= item.rect.size.width;
    }
    
    _arrMenuItems = arr;
}

- (void)pushToTalkTouchDown
{
    [_pushToTalkBtn setPushState:PushButtonStatePushed];
}

- (void)pushToTalkTouchUpInside
{
    [_pushToTalkBtn setPushState:PushButtonStateNormal];
    
}

- (void)pushToTalkTouchUpOutside
{
    [_pushToTalkBtn setPushState:PushButtonStateNormal];
}

- (void)pushToTalkTouchDragEnter
{
    [_pushToTalkBtn setPushState:PushButtonStatePushed];
}

- (void)pushToTalkTouchDragExit
{
    [_pushToTalkBtn setPushState:PushButtonStatePushedOut];
}

@end

@implementation DeviceControlBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    self.layer.cornerRadius = 8;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [getCustomColor(CustomColorTypeBorder) CGColor];
    self.layer.masksToBounds = YES;
    
    self.backgroundColor = getCustomColor(CustomColorTypeBackground);
    
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
    viewLine.backgroundColor = getCustomColor(CustomColorTypeSep);
    [view addSubview:viewLine];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = rectBtn;
    btn.backgroundColor = [UIColor clearColor];
    [btn setShowsTouchWhenHighlighted:SHOWS_TOUCH_WHEN_HIGHLIGHTED];
    [btn addTarget:self action:@selector(pageButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
}

- (void)pageButtonPressed
{
    [self switchPageViews:YES];
}

- (void)initFirstPage
{
    NSMutableArray *arr = [NSMutableArray array];
    
    MenuItem *item;
    item = [[MenuItem alloc] initWithImage:[UIImage imageNamed:@"call"] action:@selector(onActionCall)];
    [arr addObject:item];
    
    item = [[MenuItem alloc] initWithImage:[UIImage imageNamed:@"record"] action:@selector(onActionRecord) alignment:NSTextAlignmentRight];
    [arr addObject:item];
    
    item = [[MenuItem alloc] initWithImage:[UIImage imageNamed:@"monitoring"] action:@selector(onActionMonitoring) alignment:NSTextAlignmentRight];
    [arr addObject:item];
    
    item = [[MenuItem alloc] initWithImage:[UIImage imageNamed:@"heart"] action:@selector(onActionHeart) alignment:NSTextAlignmentRight];
    [arr addObject:item];
    
    item = [[MenuItem alloc] initWithName:@"按住 说话" action:@selector(onActionSpeak) bTalk:YES];
    [arr addObject:item];
    
    [_firstView setArrMenuItems:arr];
}

- (void)initSecondPage
{
    NSMutableArray *arr = [NSMutableArray array];
    
    MenuItem *item;
    item = [[MenuItem alloc] initWithName:@"互动" action:@selector(onActionInteraction)];
    [arr addObject:item];
    
    item = [[MenuItem alloc] initWithName:@"运动" action:@selector(onActionActivity)];
    [arr addObject:item];
    
    item = [[MenuItem alloc] initWithName:@"设置" action:@selector(onActionSettings)];
    [arr addObject:item];
    
    [_secondView setArrMenuItems:arr];
}

- (void)onActionCall
{
    if(_delegate && [_delegate respondsToSelector:@selector(onActionCall)])
    {
        [_delegate performSelector:@selector(onActionCall)];
    }
}

- (void)onActionHeart
{
    if(_delegate && [_delegate respondsToSelector:@selector(onActionHeart)])
    {
        [_delegate performSelector:@selector(onActionHeart)];
    }
    
}

- (void)onActionSpeak
{
    if(_delegate && [_delegate respondsToSelector:@selector(onActionSpeak)])
    {
        [_delegate performSelector:@selector(onActionSpeak)];
    }
    
}

- (void)onActionMonitoring
{
    if(_delegate && [_delegate respondsToSelector:@selector(onActionMonitoring)])
    {
        [_delegate performSelector:@selector(onActionMonitoring)];
    }
    
}

- (void)onActionRecord
{

    
}

- (void)onActionInteraction
{
    if(_delegate && [_delegate respondsToSelector:@selector(onActionInteraction)])
    {
        [_delegate performSelector:@selector(onActionInteraction)];
    }
}

- (void)onActionActivity
{
    if(_delegate && [_delegate respondsToSelector:@selector(onActionActivity)])
    {
        [_delegate performSelector:@selector(onActionActivity)];
    }
}

- (void)onActionSettings
{
    if(_delegate && [_delegate respondsToSelector:@selector(onActionSettings)])
    {
        [_delegate performSelector:@selector(onActionSettings)];
    }
}

- (void)initDeviceControl
{
    CGRect rectMain = self.bounds;
    CGRect rectIcon = rectMain;
    rectIcon.size.width = rectIcon.size.height;
    
    //first page is the main menu
    _firstView = [[MenuPageView alloc] initWithFrame:rectMain];
    
    rectMain.origin = CGPointMake(300, 300);        //make sure you can't see the second view
    _secondView = [[MenuPageView alloc] initWithFrame:rectMain];
    
    _firstView.delegate = self;
    _secondView.delegate = self;
    
    [self initPageButton:_firstView image:[UIImage imageNamed:@"menu"] rect:rectIcon];
    [self initPageButton:_secondView image:[UIImage imageNamed:@"menu"] rect:rectIcon];
    
    [self initFirstPage];
    [self initSecondPage];
    
    [self addSubview:_firstView];
    [self addSubview:_secondView];
}

- (void)switchPageViews:(BOOL)animated
{
    UIView *currentView, *nextView;
    CGRect rectMain = self.bounds;
    if(CGRectContainsPoint(rectMain, _firstView.center))
    {
        currentView = _firstView;
        nextView = _secondView;
    }
    else
    {
        currentView = _secondView;
        nextView = _firstView;
    }
    
    //here we have two animate styles
    NSUInteger mode = 1;
    if(mode % 2 == 0)
    {
        [UIView animateWithDuration:0.3f animations:^{
            currentView.center = CGPointMake(currentView.center.x, currentView.center.y + rectMain.size.height);
         }completion:^(BOOL finished){
             CGRect rect = self.bounds;
             rect.origin.y = rect.size.height;
             nextView.frame = rect;
             [UIView animateWithDuration:0.8f animations:^{
                 nextView.center = CGPointMake(nextView.center.x, rect.size.height / 2.0);
             }completion:^(BOOL finished){}];
         }];
    }
    else
    {
        CGRect rectNext = self.bounds;
        rectNext.origin.x += rectNext.size.width;
        nextView.frame = rectNext;
        
        [UIView animateWithDuration:0.3f animations:^{
            currentView.center = CGPointMake(currentView.center.x - rectMain.size.width, currentView.center.y);
            nextView.center = CGPointMake(nextView.center.x - rectMain.size.width, nextView.center.y);;
        }completion:^(BOOL finished){
        }];
    }
}

@end





