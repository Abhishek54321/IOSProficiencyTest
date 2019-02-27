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

#import "ImageButton.h"
#import "PViewUtils.h"

#define kXPadding 8.0f
#define kYPadding 6.0f


@implementation ImageButton {
    BOOL _enabled;
    CGFloat _paddingX;
    CGFloat _paddingY;
}

@synthesize button;
@synthesize enabled = _enabled;


- (id)initWithImage:(UIImage *)image target:(id)target action:(SEL)action {
    _paddingX = kXPadding;
    _paddingY = kYPadding;
    
    self = [super initWithFrame:CGRectMake(.0f, .0f, image.size.width + (_paddingX * 2.0), image.size.height + (_paddingY * 2.0f))];
    
    if (self) {
        _enabled = YES;
        
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        //[button setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)];
        button.frame = CGRectMake(.0f, .0f, image.size.width + (_paddingX * 2.0f), image.size.height + (_paddingY * 2.0f));
        [button setImage:image forState:UIControlStateNormal];
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        [PViewUtils anchorView:button top:.0f right:.0f bottom:.0f left:.0f inView:self];
        
        
        [self addSubview:button];
    }
    return self;
}

- (id)initWithImage:(UIImage *)image target:(id)target action:(SEL)action paddingX:(CGFloat)paddingX paddingY:(CGFloat)paddingY {
    _paddingX = paddingX;
    _paddingY = paddingY;
    
    self = [super initWithFrame:CGRectMake(.0f, .0f, image.size.width + (_paddingX * 2.0), image.size.height + (_paddingY * 2.0f))];
    
    if (self) {
        _enabled = YES;
        
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        //[button setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)];
        button.frame = CGRectMake(.0f, .0f, image.size.width + (_paddingX * 2.0f), image.size.height + (_paddingY * 2.0f));
        [button setImage:image forState:UIControlStateNormal];
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        [PViewUtils anchorView:button top:.0f right:.0f bottom:.0f left:.0f inView:self];
        
        [self addSubview:button];
    }
    return self;
}

- (void)setPosition:(CGPoint)point {
    self.frame = CGRectMake(point.x, point.y, self.frame.size.width, self.frame.size.height);
}

- (void)setTitle:(NSString *)title {
    UIImage *image = [button imageForState:UIControlStateNormal];
    
    [button setTitle:title forState:UIControlStateNormal];
    //  float yTextMargin = 0;//-roundf((button.frame.size.height - button.titleLabel.frame.size.height) / 2.0f);
    //float xTextMargin = - roundf((button.frame.size.width - button.titleLabel.frame.size.width) /2.0f);
    //	[button setTitleEdgeInsets:UIEdgeInsetsMake(yTextMargin + 3.0f, -image.size.width, yTextMargin - 7.0f, .0f)]; // Left inset is the negative of image width.
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0,  -image.size.width, 0, 0)];
    
    float xImageMargin = roundf((button.frame.size.width - image.size.width) / 2.0f);
    [button setImage:image forState:UIControlStateNormal];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, xImageMargin, 0, xImageMargin)]; // Right inset is the negative of text bounds width.
    //	button.backgroundColor = [UIColor redColor];
}

- (void)setAccessibilityLabel:(NSString *)accessibilityLabel {
    [button setAccessibilityLabel:accessibilityLabel];
}

- (NSString *)accessibilityLabel {
    return [button accessibilityLabel];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    [self setTitle:[button titleForState:UIControlStateNormal]];
}

- (NSString *)title {
    return [button titleForState:UIControlStateNormal];
}

- (void)addTarget:(id)target action:(SEL)action {
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

- (void)setEnabled:(BOOL)aBool {
    if (_enabled != aBool)
    {
        _enabled = aBool;
        if (aBool) {
            button.alpha = 1.0f;
            button.userInteractionEnabled = YES;
        }
        else {
            button.alpha = .4f;
            button.userInteractionEnabled = NO;
        }
    }
}

@end
