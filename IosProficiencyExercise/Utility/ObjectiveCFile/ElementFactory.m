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


#import "ElementFactory.h"
#import <QuartzCore/QuartzCore.h>
#import "FontFactory.h"
#import "PViewUtils.h"
#import "ImageButton.h"



@implementation ElementFactory

+ (UIImage *)imageOfView:(UIView *)view {
	UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, [[UIScreen mainScreen] scale]);
	CGRect originalFrame = view.frame;
	view.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
	[view.layer renderInContext:UIGraphicsGetCurrentContext()];

	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();

	view.frame = originalFrame;
	return image;
}

+ (UIImage *)resizeableImageWithImage:(UIImage *)originalImage edgeInsets:(UIEdgeInsets)edgeInsets {
	UIImage *resizeableImage;
	if ([originalImage respondsToSelector:@selector(resizableImageWithCapInsets:)]) {
		resizeableImage = [originalImage resizableImageWithCapInsets:edgeInsets];
	} else {
		resizeableImage = [originalImage stretchableImageWithLeftCapWidth:(NSInteger) edgeInsets.left topCapHeight:(NSInteger) edgeInsets.top];
	}
	return resizeableImage;
}


+ (UIImageView *)imageViewCacheOfView:(UIView *)view {
	return [[UIImageView alloc] initWithImage:[self imageOfView:view]];
}

+ (UIImageView *)imageViewOfFlatColor:(UIColor *)color {
	UIGraphicsBeginImageContext(CGSizeMake(1, 1));
	[color setFill];
	CGContextFillRect(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, 1, 1));
	UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();

	UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
	imgView.contentMode = UIViewContentModeScaleToFill;

	return imgView;

}

+ (UILabel *)clearLabelWithText:(NSString *)text font:(UIFont *)font frame:(CGRect)frame textAlign:(NSTextAlignment)textAlign {

	UILabel *label = [[UILabel alloc] initWithFrame:frame];
	label.text = text;
	label.textAlignment = textAlign;
	label.backgroundColor = [UIColor clearColor];
	label.opaque = NO;
	label.textColor = [UIColor whiteColor];
	[label setFont:font];

	if (CGSizeEqualToSize(frame.size, CGSizeZero)) {
		[self resizeLabel:label toFitNewText:text];
	}
	return label;
}

+ (void)resizeLabel:(UILabel *)label toFitNewText:(NSString *)text {
  label.text = text;
  UIFont *font = [label font];
  CGRect frame = label.frame;
  
  frame.size = [text sizeWithAttributes:
                 @{NSFontAttributeName: font}];
  label.frame = frame;
}

+ (UILabel *)clearLabelWithText:(NSString *)text font:(UIFont *)font {
	return [self clearLabelWithText:text font:font frame:CGRectZero textAlign:NSTextAlignmentLeft];
}

+ (UILabel *)clearVerticalAlignedLabelWithText:(NSString *)text font:(UIFont *)font offsetY:(NSInteger)offsetY {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(.0f, .0f, .0f, font.lineHeight)];
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = font;
    label.text = text;
    [label sizeToFit];
    return label;
}

+ (UITextView *)clearMultilineWithText:(NSString *)text font:(UIFont *)font width:(float)width textAlign:(NSTextAlignment)textAlign {
  
  UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, width, 1)];
  textView.text = text;
  textView.textAlignment = textAlign;
  textView.backgroundColor = [UIColor clearColor];
  textView.opaque = NO;
  textView.textColor = [UIColor whiteColor];
  [textView setFont:font];
  textView.userInteractionEnabled = NO;
  textView.scrollEnabled = NO;
  [textView setEditable:NO];
  
  [self resizeTextView:textView toFitNewText:text];
  
  return textView;
}

+ (void)resizeTextView:(UITextView *)textView toFitNewText:(NSString *)text {
  textView.text = text;
  float width = textView.frame.size.width;
  [textView sizeToFit];
  
  float height = ([[[UIDevice currentDevice] systemVersion]floatValue] < 7.0f) ? textView.contentSize.height : textView.frame.size.height;
  textView.frame = CGRectMake(textView.frame.origin.x, textView.frame.origin.y, width, height);
}

+(ImageButton *)darkFormButtonWithLabel:(NSString *)text target:(id)target selector:(SEL)selector width:(float)width {
    ImageButton *ret = [self formButtonWithLabelText:text
                                          labelColor:[UIColor whiteColor]
                                           imageName:@"long_button_flat_dark.png"
                                              target:target
                                            selector:selector
                                               width:width];
    
    
    return ret;
}
    + (ImageButton *)formButtonWithLabelText:(NSString *)text labelColor:(UIColor *)labelColor imageName:(NSString *)imageName target:(id)target selector:(SEL)selector width:(float)width {
        UIImage *image;
        UIImage *originalImage = [UIImage imageNamed:imageName];
        
        UIImage *resizeableImage = [self resizeableImageWithImage:originalImage edgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
        CGSize size = CGSizeMake(width, originalImage.size.height);
        UIGraphicsBeginImageContextWithOptions(size, NO, [[UIScreen mainScreen] scale]);
        
        [resizeableImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        
        ImageButton *button = [[ImageButton alloc] initWithImage:image target:target action:selector];
        //	[button.button setImage:nil forState:UIControlStateNormal];
        //	[button.button setBackgroundImage:image forState:UIControlStateNormal];
        //	button.button.imageView.contentMode = UIViewContentModeScaleAspectFit;
        button.frame = CGRectMake(0, 0, button.frame.size.width, button.frame.size.height);
        [button.button setTitleColor:labelColor forState:UIControlStateNormal];
        button.button.titleLabel.font = [FontFactory GothamMediumWithSize:12.0f];
        
        [button setAccessibilityLabel:text];
        [button setTitle:text];
        
        
        return button;
    }

+ (UIImageView *)arrowViewWithColor:(UIColor *)color {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(14, 6), NO, [[UIScreen mainScreen] scale]);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    
    CGContextMoveToPoint(context, 0, 6);
    CGContextAddLineToPoint(context, 7, 0);
    CGContextAddLineToPoint(context, 14, 6);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFill);
    
    UIImageView *arrow = [[UIImageView alloc] initWithImage:UIGraphicsGetImageFromCurrentImageContext()];
    UIGraphicsEndImageContext();
    
    return arrow;
    
}




@end
