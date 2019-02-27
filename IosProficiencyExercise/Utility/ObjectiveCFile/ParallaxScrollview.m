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
#import "ParallaxScrollview.h"
#import "PViewUtils.h"

#define kElasticConstant 0.5f

@implementation ParallaxScrollview

@synthesize backgroundView, backgroundSize, backgroundOffset, constrainParallaxDuringBounce, allowReverseParallax;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        foregroundView = [[UIView alloc] initWithFrame:self.bounds];
		backgroundView = [[UIView alloc] initWithFrame:self.bounds];
		
		backgroundOffset = CGPointZero;
		backgroundSize = CGSizeZero;
		self.contentSize = CGSizeZero;
		
		[super addSubview:backgroundView];
		[super addSubview:foregroundView];
    }
    return self;
}

- (void)dealloc {
//	NSLog(@"scrollview dealloc");
    backgroundView = nil;
	foregroundView = nil;
}

- (void) addSubview:(UIView *)view {
	[foregroundView addSubview:view];
}


- (void)setContentOffset:(CGPoint)contentOffset {
	[super setContentOffset:contentOffset];
	
	float heightDifference = self.contentSize.height - backgroundSize.height;
	if (!allowReverseParallax) heightDifference = MAX(heightDifference, 0.0f);
	
	float scrollingHeight = MAX(self.contentSize.height - self.bounds.size.height, 1.0f);
	
	float percent = contentOffset.y / scrollingHeight;
	
	float offset = heightDifference * percent;
	if (percent < 0.0f && constrainParallaxDuringBounce) {
		percent = contentOffset.y /  self.frame.size.height;
		offset = contentOffset.y + (percent * backgroundOffset.y) / kElasticConstant;
	} else if (percent > 1.0f && constrainParallaxDuringBounce) {
		percent = (contentOffset.y-scrollingHeight) /  self.frame.size.height;
		offset = heightDifference  + (self.contentOffset.y - scrollingHeight) + (percent * backgroundOffset.y) / kElasticConstant;
	} 
	[PViewUtils moveView:backgroundView toTopLeft:CGPointMake(backgroundOffset.x, offset + backgroundOffset.y)];
	
}

- (void) resize {
	[PViewUtils resizeView:backgroundView toSize:CGSizeMake(self.frame.size.width, MAX(backgroundSize.height, self.frame.size.height))];
	[PViewUtils resizeView:foregroundView toSize:CGSizeMake(self.frame.size.width, self.contentSize.height)];
}

- (void)layoutSubviews {
	
	[super layoutSubviews];
	[self resize];
}


- (void) setContentSize:(CGSize)contentSize {
	[super setContentSize:contentSize];
	[self resize];
}

@end
