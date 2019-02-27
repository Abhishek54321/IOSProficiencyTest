/** -------------------------------------------------------------
 * Copyright (C) 2017 Redken, Inc. All trade marks registered
 *
 * This file is part of Redken Style Station Mobile Project.
 *
 * Redken Style Station Mobile Project can not be copied and/or
 *
 * distributed without the express permission of Redken, Inc.
 *
 * -------------------------------------------------------------
 **/

#import <QuartzCore/QuartzCore.h>
#import "KnImageUtils.h"

@implementation KnImageUtils

+(UIImage*)resizeImage:(UIImage*)image size:(CGSize)tgSize
{
    UIImage *newImage;
    
    UIGraphicsBeginImageContextWithOptions(tgSize, YES, 0.0);
    
    float ratioW = tgSize.width / image.size.width;
    float ratioH = tgSize.height / image.size.height;
    float ratio = MAX(ratioW, ratioH);
    
    float newW = roundf(image.size.width * ratio);
    float newH = roundf(image.size.height * ratio);
    
    [image drawInRect:CGRectMake(roundf((tgSize.width - newW) / 2.0f), roundf((tgSize.height - newH) / 2.0f), newW, newH)];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

+(UIImage*)resizeImage:(UIImage*)image sizeIn:(CGSize)tgSize transparent:(BOOL)transparent
{
    UIImage *newImage;
    
    UIGraphicsBeginImageContextWithOptions(tgSize, !transparent, 0.0);
    
    float ratioW = tgSize.width / image.size.width;
    float ratioH = tgSize.height / image.size.height;
    float ratio = MIN(ratioW, ratioH);
    
    float newW = roundf(image.size.width * ratio);
    float newH = roundf(image.size.height * ratio);
    
    [image drawInRect:CGRectMake(roundf((tgSize.width - newW) / 2.0f), roundf((tgSize.height - newH) / 2.0f), newW, newH)];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

+(UIImage*)resizeImage:(UIImage*)image scale:(float)scale transparent:(BOOL)transparent
{
    UIImage *newImage;
    CGSize tgSize = CGSizeMake(roundf(image.size.width * scale), roundf(image.size.height * scale));
    
    UIGraphicsBeginImageContextWithOptions(tgSize, !transparent, 0.0);
    
    [image drawInRect:CGRectMake(.0f, .0f, tgSize.width, tgSize.height)];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

+(UIImage*)solidColorImageWithColor:(UIColor*)color size:(CGSize)size
{
    UIImage *newImage;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, CGRectMake(.0f, .0f, size.width, size.height));
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    return newImage;
}

+ (UIImage *)getImageFromUIView:(UIView *)aView {
    UIGraphicsBeginImageContextWithOptions(aView.bounds.size, NO, 0.0);
    
    [aView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

@end
