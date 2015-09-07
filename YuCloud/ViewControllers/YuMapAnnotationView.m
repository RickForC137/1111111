//
//  YuMapAnnotationView.m
//  YuCloud
//
//  Created by 熊国锋 on 15/9/7.
//  Copyright © 2015年 VIROYAL-ELEC. All rights reserved.
//

#import "YuMapAnnotationView.h"


#define kWidth  50.f
#define kHeight 50.f

#define kHoriMargin 5.f
#define kVertMargin 5.f

#define kPortraitWidth  50.f
#define kPortraitHeight 50.f

#define kCalloutWidth   200.0
#define kCalloutHeight  70.0

@interface YuMapAnnotationView ()

@property (nonatomic, strong) UIImageView *portraitImageView;

@end

@implementation YuMapAnnotationView

@synthesize calloutView;
@synthesize portraitImageView   = _portraitImageView;

#pragma mark - Handle Action

- (void)btnAction
{
    CLLocationCoordinate2D coorinate = [self.annotation coordinate];
    
    NSLog(@"coordinate = {%f, %f}", coorinate.latitude, coorinate.longitude);
}

#pragma mark - Override

- (UIImage *)portrait
{
    return self.portraitImageView.image;
}

- (void)setPortrait:(UIImage *)portrait
{
    self.portraitImageView.image = portrait;
}

- (void)setSelected:(BOOL)selected
{
    [self setSelected:selected animated:NO];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (self.selected == selected)
    {
        return;
    }
    
    if(_calloutEnabled)
    {
        if (selected)
        {
            if (self.calloutView == nil)
            {
                /* Construct custom callout. */
                self.calloutView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kCalloutWidth, kCalloutHeight)];
                self.calloutView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f + self.calloutOffset.x,
                                                      -CGRectGetHeight(self.calloutView.bounds) / 2.f + self.calloutOffset.y);
                
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                btn.frame = CGRectMake(10, 10, 40, 40);
                [btn setTitle:@"Test" forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
                [btn setBackgroundColor:[UIColor whiteColor]];
                [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
                
                [self.calloutView addSubview:btn];
                
                UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, 100, 30)];
                name.backgroundColor = [UIColor clearColor];
                name.textColor = [UIColor whiteColor];
                name.text = @"Hello Amap!";
                [self.calloutView addSubview:name];
            }
            
            [self addSubview:self.calloutView];
        }
        else
        {
            [self.calloutView removeFromSuperview];
        }
    }
    
    [super setSelected:selected animated:animated];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL inside = [super pointInside:point withEvent:event];
    /* Points that lie outside the receiver’s bounds are never reported as hits,
     even if they actually lie within one of the receiver’s subviews.
     This can occur if the current view’s clipsToBounds property is set to NO and the affected subview extends beyond the view’s bounds.
     */
    if (!inside && self.selected && _calloutEnabled)
    {
        inside = [self.calloutView pointInside:[self convertPoint:point toView:self.calloutView] withEvent:event];
    }
    
    return inside;
}

#pragma mark - Life Cycle

- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.bounds = CGRectMake(0.f, 0.f, kWidth, kHeight);
        self.backgroundColor = [UIColor clearColor];
        
        /* Create portrait image view and add to view hierarchy. */
        CGRect rectMain = self.bounds;
        UIImageView *backView = [[UIImageView alloc] initWithFrame:rectMain];
        backView.image = [UIImage imageNamed:@"annotation"];
        [self addSubview:backView];
        
        CGRect rectPortrait = CGRectInset(rectMain, 8, 8);
        rectPortrait.origin.y -= 5;
        _portraitImageView = [[UIImageView alloc] initWithFrame:rectPortrait];
        _portraitImageView.layer.cornerRadius = rectPortrait.size.width / 2.0;
        _portraitImageView.layer.borderWidth = 0;
        _portraitImageView.layer.masksToBounds = YES;
        
        [self addSubview:_portraitImageView];
    }
    
    return self;
}






@end


