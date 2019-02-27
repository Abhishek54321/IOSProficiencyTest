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

#import "TipButton.h"

@implementation TipButton


- (id)initWithNormalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage target:(id)target action:(SEL)action {

	button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.frame = CGRectMake(-3, 0, MAX(normalImage.size.width + 10, 50.0f), MAX(normalImage.size.height + 10, 44.0f));
	float offset = button.frame.size.width - normalImage.size.width - 3;
	button.imageEdgeInsets = UIEdgeInsetsMake(0, offset, 0, 0);
	[button setImage:normalImage forState:UIControlStateNormal];
	[button setImage:selectedImage forState:UIControlStateSelected];
	[button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];

	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, button.frame.size.width, button.frame.size.height)];
	[view addSubview:button];

	self = [super initWithCustomView:view];
	if (self) {
		self.selected = NO;
	}
	return self;
}

- (void)setSelected:(BOOL)aSelected {
	button.selected = aSelected;
}


- (BOOL)selected {
	return button.selected;
}

- (NSString *)accessibilityLabel {
	return [button accessibilityLabel];
}

- (void)setAccessibilityLabel:(NSString *)accessibilityLabel {
	[button setAccessibilityLabel:accessibilityLabel];
}


@end
