//
//  BlurredImageView.m
//  YuCloud
//
//  Created by 熊国锋 on 15/8/27.
//  Copyright (c) 2015年 VIROYAL-ELEC. All rights reserved.
//

#import "BlurredImageView.h"


@implementation BlurredImageView
{
    UIImageView   *_imageView;
    UIImageView   *_blurredImageView;
}

- (id)initWithImage:(UIImage *)image
{
    // Make sure we have an image to work with
    if (!image)
    {
        return nil;
    }
    
    // Calculate frame size
    CGRect frame = (CGRect){CGPointZero, image.size};
    
    self = [super initWithFrame:frame];
    
    if (!self)
    {
        return nil;
    }
    
    // Pass along parameters
    _image = image;
    
    [self BlurredImageView_commonInit];
    
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    _blurredImageView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    _imageView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    
}

- (void)BlurredImageView_commonInit
{
    // Make sure we're not subclassed
    if ([self class] != [BlurredImageView class])
        return;
    
    // Set up regular image
    _imageView = [[UIImageView alloc] initWithImage:_image];
    [self addSubview:_imageView];
    
    // Set blurred image
    _blurredImageView = [[UIImageView alloc] initWithImage:[self blurredImage]];
    [_blurredImageView setAlpha:0.95f];
    
    if (_blurredImageView)
    {
        [self addSubview:_blurredImageView];
    }
}

- (UIImage *)blurredImage
{
    // Make sure that we have an image to work with
    if (!_image)
        return nil;
    
    // Create context
    CIContext *context = [CIContext contextWithOptions:nil];
    
    // Create an image
    CIImage *image = [CIImage imageWithCGImage:_image.CGImage];
    
    // Set up a Gaussian Blur filter
    CIFilter *blurFilter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [blurFilter setValue:image forKey:kCIInputImageKey];
    
    // Get blurred image out
    CIImage *blurredImage = [blurFilter valueForKey:kCIOutputImageKey];
    
    // Set up vignette filter
    CIFilter *vignetteFilter = [CIFilter filterWithName:@"CIVignette"];
    [vignetteFilter setValue:blurredImage forKey:kCIInputImageKey];
    [vignetteFilter setValue:@(4.f) forKey:@"InputIntensity"];
    
    // get vignette & blurred image
    CIImage *vignetteImage = [vignetteFilter valueForKey:kCIOutputImageKey];
    
    CGFloat scale = [[UIScreen mainScreen] scale];
    CGSize scaledSize = CGSizeMake(_image.size.width * scale, _image.size.height * scale);
    CGImageRef imageRef = [context createCGImage:vignetteImage fromRect:(CGRect){CGPointZero, scaledSize}];
    
    return [UIImage imageWithCGImage:imageRef scale:[[UIScreen mainScreen] scale] orientation:UIImageOrientationUp];
}

- (void)setBlurIntensity:(CGFloat)blurIntensity
{
    if (blurIntensity < 0.f)
        blurIntensity = 0.f;
    else if (blurIntensity > 1.f)
        blurIntensity = 1.f;
    
    _blurIntensity = blurIntensity;
    
    [_blurredImageView setAlpha:blurIntensity];
}


@end


