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
#import <UIKit/UIKit.h>

@interface ParallaxScrollview : UIScrollView {
	UIView *foregroundView;
}

@property (nonatomic, assign) CGSize backgroundSize;
@property (nonatomic, readonly, strong) UIView *backgroundView;
@property (nonatomic, assign) CGPoint backgroundOffset;
@property (nonatomic, assign) BOOL constrainParallaxDuringBounce;

//this allows the background to move faster than the foreground;
@property (nonatomic, assign) BOOL allowReverseParallax;

//parallax on bouncing only
//parallax on 

@end
