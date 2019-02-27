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

#define kMarginFlexible NAN

typedef enum {
	ALIGN_ABOVE,
	ALIGN_ABOVE_LEFT,
	ALIGN_ABOVE_RIGHT,
	ALIGN_BELOW,
	ALIGN_BELOW_LEFT,
	ALIGN_BELOW_RIGHT,
	ALIGN_LEFT, //move to the left of the object (before)
	ALIGN_LEFT_TOP,
	ALIGN_LEFT_BOTTOM,
	ALIGN_RIGHT,
	ALIGN_RIGHT_TOP,
	ALIGN_RIGHT_BOTTOM
} ALIGN;

@interface PViewUtils : NSObject {
    
}

+ (void) moveView:(UIView *)view toCenter:(CGPoint)center;
+ (void) moveView:(UIView *)view toTopLeft:(CGPoint)origin;
+ (void) centerView:(UIView*)view withinSize:(CGSize)size;
+ (void) anchorView:(UIView*)view top:(float)topMargin right:(float)rightMargin bottom:(float)bottomMargin left:(float)leftMargin inView:(UIView*)parentView;
+ (void) alignView:(UIView*)view toView:(UIView*)referenceView alignment:(ALIGN)alignment offset:(float)offset;
+ (void)resizeView:(UIView*)view toSize:(CGSize)size;
+ (float)getFlexibleMargin;
+ (void)moveView:(UIView *)view toTopRight:(CGPoint)point;
@end
