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
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface KnImageUtils : NSObject

+(UIImage*)resizeImage:(UIImage*)image size:(CGSize)tgSize;
+(UIImage*)resizeImage:(UIImage*)image sizeIn:(CGSize)tgSize transparent:(BOOL)transparent;
+(UIImage*)resizeImage:(UIImage*)image scale:(float)scale transparent:(BOOL)transparent;
+(UIImage*)solidColorImageWithColor:(UIColor*)color size:(CGSize)size;

+ (UIImage *)getImageFromUIView:(UIView *)aView;


@end
