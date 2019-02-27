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


@interface MultilineLabel : UIView {
    NSMutableArray *labels;
	NSString *_text;
	float _width;
	UIView *container;
	NSTextAlignment _textAlignment;
	float _lineHeight;
	int _numLines;
}

- (id)initWithFont:(UIFont*)font width:(float)width numLines:(int)numLines lineHeight:(float)lineHeight;

+ (MultilineLabel*)labelWithFont:(UIFont*)font width:(float)width lineHeight:(float)lineHeight text:(NSString*)text;

@property (nonatomic, retain) NSString *text;
@property (nonatomic, retain) UIColor *textColor;
@property (nonatomic, assign) NSTextAlignment textAlignment;
@property (nonatomic, assign) BOOL avoidWidows;

@end
