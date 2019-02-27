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

@interface ImageButton : UIView
{
	UIButton *button;
}

@property (nonatomic, readonly) UIButton *button;
@property (nonatomic, retain) NSString *title;
@property(nonatomic) BOOL enabled;


-(id)initWithImage:(UIImage*)image target:(id)target action:(SEL)action;

- (id)initWithImage:(UIImage *)image target:(id)target action:(SEL)action paddingX:(CGFloat)paddingX paddingY:(CGFloat)paddingY;

-(void)setPosition:(CGPoint)point;
-(void)addTarget:(id)target action:(SEL)action;

@end
