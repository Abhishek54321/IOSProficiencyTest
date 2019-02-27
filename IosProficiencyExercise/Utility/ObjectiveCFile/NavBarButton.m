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
#import "NavBarButton.h"
#import "ElementFactory.h"
#import "FontFactory.h"
#import <UIKit/UIKit.h>


@implementation NavBarButton {
	UIButton *_button;
	void (^_targetBlock)();
	UIImage *_bgImage;
	UIEdgeInsets _edgeInsets;
	UIColor *_textColor;
	UIImage *_bgImageHighlighted;
    UINavigationController *_navController;
}


+ (NavBarButton *)backButtonWithText:(NSString *)text navController:(UINavigationController *)navController {
	if (text == nil && [navController.viewControllers count] > 1) {
		//UIViewController *targetViewController = [navController.viewControllers objectAtIndex:[navController.viewControllers count] - 2];
		//text = targetViewController.title;
	}

	UIImage *backButtonImage = [UIImage imageNamed:@"ic_back"];
//	UIImage *backButtonImageHighlighted = [UIImage imageNamed:@"backButton_highlighted.png"];
    NavBarButton *button = [[NavBarButton alloc] initWithCustomView:backButtonImage];
//	NavBarButton *button = [[NavBarButton alloc] ini initWithText:text image:backButtonImage imageHighlighted:backButtonImageHighlighted edgeInsets:UIEdgeInsetsMake(11, 25, 10, 16)];

	__unsafe_unretained UINavigationController *navigationController = navController;
	button.block = ^{
		[navigationController popViewControllerAnimated:YES];
	};
	return button;

}

- (NavBarButton *)initBackButtonWithNavController:(UINavigationController *)navController {
    self = [super init];
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageNamed:@"ic_back"];
    _button.frame = CGRectMake(0, 0, MIN(40.0f, image.size.width + 6), 44.0f);
    [_button setImage:image forState:UIControlStateNormal];
    [_button setImage:image forState:UIControlStateHighlighted];
    [_button setAccessibilityLabel:NSLocalizedString(@"Back", @"Home Button accessibility label")];
    
    //	[button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _button.frame.size.width, _button.frame.size.height)];
    [view addSubview:_button];
    
    _navController = navController;
    
    [_button addTarget:self action:@selector(didTouch) forControlEvents:UIControlEventTouchUpInside];
    
    return [self initWithCustomView:view];
}

- (void) didTouch {
    [_navController popViewControllerAnimated:YES];
}

+ (NavBarButton *)buttonWithText:(NSString *)text {
	UIImage *navButtonBg = [UIImage imageNamed:@"navBarButton.png"];
	UIImage *navButtonHighlightBg = [UIImage imageNamed:@"navBarButton_highlighted.png"];
	return [[NavBarButton alloc] initWithText:text image:navButtonBg imageHighlighted:navButtonHighlightBg edgeInsets:UIEdgeInsetsMake(12, 16, 10, 16)];
}

- (UIImage *)generateButtonImageWithText:(NSString *)string image:(UIImage *)originalImage edgeInsets:(UIEdgeInsets)edgeInsets {
	UIImage *image;
	UIImage *resizeableImage = [ElementFactory resizeableImageWithImage:originalImage edgeInsets:edgeInsets];
	UILabel *label = [ElementFactory clearLabelWithText:string font:[FontFactory TradeGothicBoldCondensedWithSize:12.0f]];
	label.textColor = (_textColor == nil) ? [UIColor colorWithWhite:0.7f alpha:1.0f] : _textColor;

	float width = label.frame.size.width + edgeInsets.left + edgeInsets.right;

	CGSize size = CGSizeMake(width, originalImage.size.height);
	UIGraphicsBeginImageContextWithOptions(size, NO, 0);

	[resizeableImage drawInRect:CGRectMake(0, 0, size.width, size.height)];

	CGContextSaveGState(UIGraphicsGetCurrentContext());
	CGContextTranslateCTM(UIGraphicsGetCurrentContext(), edgeInsets.left, edgeInsets.top);
	[label.layer renderInContext:UIGraphicsGetCurrentContext()];

	CGContextRestoreGState(UIGraphicsGetCurrentContext());

	image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();

	return image;
}

- (UIView *)buildButtonView {
	_button = [UIButton buttonWithType:UIButtonTypeCustom];
	_button.frame = CGRectMake(0, 0, 50, 44.0f);

	UIView *backView = [[UIView alloc] initWithFrame:_button.bounds];
	[backView addSubview:_button];

	return backView;

}


- (void)configureButtonViewWithImage:(UIImage *)buttonImage imageHighlighted:(UIImage *)buttonImageHighlighted {
	[_button setImage:buttonImage forState:UIControlStateNormal];
	if (buttonImageHighlighted) [_button setImage:buttonImageHighlighted forState:UIControlStateHighlighted];
	_button.frame = CGRectMake(0, 0, MAX(buttonImage.size.width, 44.0f), 44.0f);
	self.customView.bounds = _button.bounds;
	self.customView = self.customView;
}

- (id)initWithText:(NSString *)text image:(UIImage *)image imageHighlighted:(UIImage *)imageHighlight edgeInsets:(UIEdgeInsets)edgeInsets {
	UIView *buttonView = [self buildButtonView];
	self = [super initWithCustomView:buttonView];
	if (self) {
		_bgImage = image;
		_bgImageHighlighted = imageHighlight;
		_edgeInsets = edgeInsets;
		[self setText:text];
	}

	return self;
}

- (id)initWithText:(NSString *)text image:(UIImage *)image edgeInsets:(UIEdgeInsets)edgeInsets {
	UIView *buttonView = [self buildButtonView];
	self = [super initWithCustomView:buttonView];
	if (self) {
		_bgImage = image;
		_edgeInsets = edgeInsets;
		[self setText:text];
	}

	return self;
}

- (id)initWithText:(NSString *)text textColor:(UIColor *)aTextColor image:(UIImage *)image edgeInsets:(UIEdgeInsets)edgeInsets {
	UIView *buttonView = [self buildButtonView];
	self = [super initWithCustomView:buttonView];
	if (self) {
		_bgImage = image;
		_edgeInsets = edgeInsets;
		_textColor = aTextColor;
		[self setText:text];
	}

	return self;
}

- (BOOL)userInteractionEnabled {
	return _button.userInteractionEnabled;
}

- (void (^)())block {
	return _targetBlock;

}

- (void)setBlock:(void (^)())aBlock {
	_targetBlock = aBlock;
	[self addTarget:self action:@selector(doBlock) forControlEvents:UIControlEventTouchUpInside];

}


- (void)setUserInteractionEnabled:(BOOL)userInteractionEnabled {
	_button.userInteractionEnabled = userInteractionEnabled;
	_button.alpha = userInteractionEnabled ? 1.0f : 0.4f;
}


- (void)doBlock {
	_targetBlock();
}

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
	[_button removeTarget:self action:@selector(doBlock) forControlEvents:UIControlEventTouchUpInside];
	[_button addTarget:target action:action forControlEvents:controlEvents];
}

- (void)setText:(NSString *)text {
	text = [text uppercaseString];
	UIImage *buttonImage = [self generateButtonImageWithText:text image:_bgImage edgeInsets:_edgeInsets];

	if (_bgImageHighlighted) {
		UIImage *buttonImageHighlight = [self generateButtonImageWithText:text image:_bgImageHighlighted edgeInsets:_edgeInsets];
		[self configureButtonViewWithImage:buttonImage imageHighlighted:buttonImageHighlight];
	}
	else {
		[self configureButtonViewWithImage:buttonImage imageHighlighted:nil];
	}


	[_button setAccessibilityLabel:text];
}


@end
