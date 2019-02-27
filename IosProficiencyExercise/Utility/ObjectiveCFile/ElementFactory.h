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
#import "TipButton.h"
#import "ImageButton.h"

@class HomeButton;
@class HeaderView;



@protocol HeaderViewDelegate <NSObject>

- (void)didSelectShare;

@end


@interface ElementFactory : NSObject

+ (UIImage *)imageOfView:(UIView*)view;
+ (UIImage *)resizeableImageWithImage:(UIImage *)originalImage edgeInsets:(UIEdgeInsets)edgeInsets;
+ (UIImageView *)imageViewCacheOfView:(UIView*)view;
+ (UIImageView *)imageViewOfFlatColor:(UIColor*)color;

+ (void)resizeLabel:(UILabel *)label toFitNewText:(NSString *)text;
+ (UILabel*)clearLabelWithText:(NSString*)text font:(UIFont*)font;
+ (UITextView *)clearMultilineWithText:(NSString *)text font:(UIFont *)font width:(float)width textAlign:(NSTextAlignment)textAlign;
+(ImageButton *)darkFormButtonWithLabel:(NSString *)text target:(id)target selector:(SEL)selector width:(float)width;
+ (UIImageView *)arrowViewWithColor:(UIColor *)color;
+ (void)resizeTextView:(UITextView*)textView toFitNewText:(NSString*)text;

@end
