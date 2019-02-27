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

#import "PViewUtils.h"

@implementation PViewUtils

+ (void) moveView:(UIView *)view toCenter:(CGPoint)center {
	view.center = center;
	CGRect frame = view.frame;
	frame.origin = CGPointMake(roundf(frame.origin.x), roundf(frame.origin.y));
	view.frame = frame;
}

+ (void) moveView:(UIView *)view toTopLeft:(CGPoint)origin {
	CGRect frame = view.frame;
	frame.origin = origin;
	view.frame = frame;
}

+ (void) centerView:(UIView*)view withinSize:(CGSize)size {
	[PViewUtils moveView:view toCenter:CGPointMake(size.width / 2.0f, size.height / 2.0f)];
}


+ (void) anchorView:(UIView*)view top:(float)topMargin right:(float)rightMargin bottom:(float)bottomMargin left:(float)leftMargin inView:(UIView*)parentView {

	UIViewAutoresizing autoresizing = 0;
	CGRect frame = view.frame;
	if (isnan(topMargin)) {
		autoresizing = UIViewAutoresizingFlexibleTopMargin;
	} else {
		frame.origin.y = topMargin;
	}
	
	if (isnan(bottomMargin)) {
		autoresizing = autoresizing | UIViewAutoresizingFlexibleBottomMargin;
	} else {
		if (!isnan(topMargin)) {
			//top and bottom set
			autoresizing = autoresizing | UIViewAutoresizingFlexibleHeight;
			frame.size.height = parentView.frame.size.height - topMargin - bottomMargin;
		} else {
			//flexible top
			frame.origin.y = roundf(parentView.frame.size.height - bottomMargin - view.frame.size.height);
		}
	}
		
	
	
	if (isnan(leftMargin)) {
		autoresizing = autoresizing | UIViewAutoresizingFlexibleLeftMargin;
	} else {
		frame.origin.x = leftMargin;
	}
	
	if (isnan(rightMargin)) {
		autoresizing = autoresizing | UIViewAutoresizingFlexibleRightMargin;
	} else  {
		if (!isnan(leftMargin)) {
			//left and right set
			autoresizing = autoresizing | UIViewAutoresizingFlexibleWidth;
			frame.size.width = parentView.frame.size.width - leftMargin - rightMargin;
		} else {
			//flexible left
			frame.origin.x = roundf(parentView.frame.size.width - rightMargin - view.frame.size.width);
		}
	}
	
	if (isnan(leftMargin) && isnan(rightMargin)) {
		frame.origin.x = roundf((parentView.frame.size.width - view.frame.size.width) / 2.0f);
	}
	
	if (isnan(topMargin) && isnan(bottomMargin)) {
		frame.origin.y = roundf((parentView.frame.size.height - view.frame.size.height) / 2.0f);
	}
	
	
	view.frame = frame;
	view.autoresizingMask = autoresizing;
}


+ (void) alignView:(UIView*)view toView:(UIView*)referenceView alignment:(ALIGN)alignment offset:(float)offset {
	switch (alignment) {
		case ALIGN_ABOVE:
			[PViewUtils moveView:view toCenter:CGPointMake(referenceView.center.x, referenceView.center.y - referenceView.frame.size.height / 2 - offset - view.frame.size.height / 2)];
			break;
		
		case ALIGN_ABOVE_LEFT:
			[PViewUtils moveView:view toTopLeft:CGPointMake(referenceView.frame.origin.x, referenceView.frame.origin.y - view.frame.size.height - offset)];
			break;
			
		case ALIGN_ABOVE_RIGHT:
			[PViewUtils moveView:view toTopLeft:CGPointMake(referenceView.frame.origin.x + referenceView.frame.size.width - view.frame.size.width, referenceView.frame.origin.y - view.frame.size.height - offset)];
			break;
			
		case ALIGN_BELOW:
			[PViewUtils moveView:view toCenter:CGPointMake(referenceView.center.x, referenceView.center.y + referenceView.frame.size.height / 2 + view.frame.size.height / 2 + offset)];
			break;
			
		case ALIGN_BELOW_LEFT:
			[PViewUtils moveView:view toTopLeft:CGPointMake(referenceView.frame.origin.x, referenceView.frame.origin.y + referenceView.frame.size.height + offset)];
			break;
			
		case ALIGN_BELOW_RIGHT:
			[PViewUtils moveView:view toTopLeft:CGPointMake(referenceView.frame.origin.x + referenceView.frame.size.width - view.frame.size.width, referenceView.frame.origin.y + referenceView.frame.size.height + offset)];
			break;
			
		case ALIGN_LEFT:
			[PViewUtils moveView:view toTopLeft:CGPointMake(referenceView.frame.origin.x - view.frame.size.width - offset, referenceView.frame.origin.y + referenceView.frame.size.height / 2 - view.frame.size.height / 2)];
			break;
			
		case ALIGN_LEFT_BOTTOM:
			[PViewUtils moveView:view toTopLeft:CGPointMake(referenceView.frame.origin.x - view.frame.size.width - offset, referenceView.frame.origin.y + referenceView.frame.size.height - view.frame.size.height)];
			break;
			
		case ALIGN_LEFT_TOP:
			[PViewUtils moveView:view toTopLeft:CGPointMake(referenceView.frame.origin.x - view.frame.size.width - offset, referenceView.frame.origin.y)];
			break;
			
		case ALIGN_RIGHT:
			[PViewUtils moveView:view toTopLeft:CGPointMake(referenceView.frame.origin.x + referenceView.frame.size.width + offset, referenceView.frame.origin.y + referenceView.frame.size.height / 2 - view.frame.size.height / 2)];
			break;
			
		case ALIGN_RIGHT_BOTTOM:
			[PViewUtils moveView:view toTopLeft:CGPointMake(referenceView.frame.origin.x + referenceView.frame.size.width + offset, referenceView.frame.origin.y + referenceView.frame.size.height + view.frame.size.height)];
			break;
			
		case ALIGN_RIGHT_TOP:
			[PViewUtils moveView:view toTopLeft:CGPointMake(referenceView.frame.origin.x + referenceView.frame.size.width + offset, referenceView.frame.origin.y)];
			break;
			
		default:
			break;
	}
}

+ (void)resizeView:(UIView*)view toSize:(CGSize)size {
	CGRect frame = view.frame;
	frame.size = size;
	view.frame = frame;
}

  +(float)getFlexibleMargin
  {
    return kMarginFlexible;
  }

+ (void)moveView:(UIView *)view toTopRight:(CGPoint)point {
    [self moveView:view toTopLeft:CGPointMake(point.x - view.frame.size.width, point.y)];
}
@end
