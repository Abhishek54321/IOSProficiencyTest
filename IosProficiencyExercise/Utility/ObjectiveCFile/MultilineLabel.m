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

#import "MultilineLabel.h"
//#import "TextFieldFactory.h"
#import "PViewUtils.h"
#import "ElementFactory.h"

@interface MultilineLabel ()

@property (nonatomic, retain) NSString *_text;
@property (nonatomic, retain) UIColor *_textColor;
@property (nonatomic, retain) UIFont *_font;

@end


@implementation MultilineLabel

@synthesize _text, _textColor, _font, avoidWidows;


//automatic line #
+ (MultilineLabel*)labelWithFont:(UIFont*)font width:(float)width lineHeight:(float)lineHeight text:(NSString*)text {
	if (![text isKindOfClass:[NSString class]]) text = @".";
	NSMutableArray *lines = [NSMutableArray array];
//	NSLog(@"%@",[NSThread callStackSymbols]);
	NSArray *hardWrappedSegments = [text componentsSeparatedByString:@"\n"];
	for (NSString *part in hardWrappedSegments) {
		NSString *currentLine = @"";
		NSArray *words = [part componentsSeparatedByString:@" "];
		for (NSString *word in words) {
			NSString *updatedLine;
			if ([currentLine length] == 0) {
				updatedLine = word;
			} else {
				updatedLine = [NSString stringWithFormat:@"%@ %@", currentLine, word];
			}
			if ([updatedLine sizeWithAttributes:@{NSFontAttributeName: font}].width > width) {
				[lines addObject:currentLine];
				currentLine = word;
			} else {
				currentLine = updatedLine;
			}
		}
		if ([currentLine length] > 0) {
			[lines addObject:currentLine];
		}
	}
	
	MultilineLabel *label = [[MultilineLabel alloc] initWithFont:font width:width numLines:(int)[lines count] lineHeight:lineHeight];
	label.textColor = [UIColor whiteColor];
	label.text = text;
	
	return label;
}





- (id)initWithFont:(UIFont*)font width:(float)width numLines:(int)numLines lineHeight:(float)lineHeight {
	
	CGRect frame = CGRectMake(0, 0, width, lineHeight * numLines);
    self = [super initWithFrame:frame];
    if (self) {
        labels = [NSMutableArray array];
		_width = width;
		self._font = font;
		_lineHeight = lineHeight;
		_numLines = numLines;
		
		container = [[UIView alloc] initWithFrame:self.bounds];
		[self addSubview:container];
		self.clipsToBounds = NO;
		_textAlignment = NSTextAlignmentLeft;
		self.isAccessibilityElement = YES;
    }
    return self;
}

- (NSString*)text {
	return _text;
}

- (void) setText:(NSString *)text {
	self._text = text;
	
	self.accessibilityValue = text;
	
	NSMutableArray *lines = [NSMutableArray array];
	
	NSArray *hardWrappedSegments = [text componentsSeparatedByString:@"\n"];
	for (NSString *part in hardWrappedSegments) {
		NSString *currentLine = @"";
		NSArray *words = [part componentsSeparatedByString:@" "];
		for (NSString *word in words) {
			NSString *updatedLine;
			if ([currentLine length] == 0) {
				updatedLine = word;
			} else {
				updatedLine = [NSString stringWithFormat:@"%@ %@", currentLine, word];
			}
			if ([updatedLine sizeWithAttributes:@{NSFontAttributeName: _font}].width > _width) {
				[lines addObject:currentLine];
				currentLine = word;
			} else {
				currentLine = updatedLine;
			}
		}
		if ([currentLine length] > 0) {
			[lines addObject:currentLine];
		}
	}
	
	
	if (avoidWidows && [lines count] > 1 && [hardWrappedSegments count] == 1) {
		NSArray *lastLineWords = [[lines objectAtIndex:[lines count]-1] componentsSeparatedByString:@" "];
		NSArray *prevLineWords = [[lines objectAtIndex:[lines count]-2] componentsSeparatedByString:@" "];

		while ([prevLineWords count] > 2 && ([lastLineWords count] == 1 || [[lastLineWords objectAtIndex:0] length] + [[lastLineWords lastObject] length] < 7)) {
			lastLineWords = [[NSArray arrayWithObject:[prevLineWords lastObject]] arrayByAddingObjectsFromArray:lastLineWords];
			
			prevLineWords = [prevLineWords subarrayWithRange:NSMakeRange(0, [prevLineWords count]-1)];
		}
		[lines removeObjectsInRange:NSMakeRange([lines count]-2, 2)];
		[lines addObject:[prevLineWords componentsJoinedByString:@" "]];
		[lines addObject:[lastLineWords componentsJoinedByString:@" "]];
	}
	
	
	NSUInteger i;
    UILabel *label = nil;
	for (i = 0; i < MIN([lines count], _numLines); i++) {
		NSString *line = [lines objectAtIndex:i];
		if ([labels count] > i) {
			label = [labels objectAtIndex:i];
		} else {
			label = [self clearLabelWithText:line font:_font frame:CGRectZero textAlign:NSTextAlignmentLeft];
			label.textAlignment = _textAlignment;
			label.textColor = _textColor;
			label.frame = CGRectMake(0, 0, _width, label.frame.size.height);
			[PViewUtils moveView:label toTopLeft:CGPointMake(0, _lineHeight * i)];
			[container addSubview:label];
			[labels addObject:label];
		}
		label.text = line;
        
//		[TextFieldFactory resizeLabel:label toFitNewText:line];
	}
    //add elipses if needed.
	if ([lines count] > _numLines) {
        NSString *newText = (label) ? label.text : @""; //label should never be nil, but this will fix an analyzer warning
        while ([[newText stringByAppendingString:@"..."] sizeWithAttributes:@{NSFontAttributeName: _font}].width > _width) {
            newText = [newText substringToIndex:[newText length]-1];
        }
        [self resizeLabel:label toFitNewText:[newText stringByAppendingString:@"..."]];
    }
	while ([labels count] > i) {
		[[labels lastObject] removeFromSuperview];
		[labels removeLastObject];
	}

	container.frame = CGRectMake(0, roundf((_numLines * _lineHeight -  _lineHeight * i) / 2), _width, _lineHeight * i);

	[PViewUtils centerView:container withinSize:self.frame.size];
}
  
- (UILabel *)clearLabelWithText:(NSString *)text font:(UIFont *)font frame:(CGRect)frame textAlign:(NSTextAlignment)textAlign {
  
  UILabel *label = [[UILabel alloc] initWithFrame:frame];
  label.text = text;
  label.textAlignment = textAlign;
  label.backgroundColor = [UIColor clearColor];
  label.opaque = NO;
  label.textColor = [UIColor whiteColor];
  //	label.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:0.4f];
  //	label.shadowOffset = CGSizeMake(0, 1);
  [label setFont:font];
  
  if (CGSizeEqualToSize(frame.size, CGSizeZero)) {
    [self resizeLabel:label toFitNewText:text];
  }
  return label;
}
  
  - (void)resizeLabel:(UILabel *)label toFitNewText:(NSString *)text {
    label.text = text;
    UIFont *font = [label font];
    CGRect frame = label.frame;
    frame.size = [text sizeWithAttributes:@{NSFontAttributeName: font}];
    label.frame = frame;
  }


- (UIColor *)textColor {
	return self._textColor;
}

- (void) setTextColor:(UIColor *)textColor {
	self._textColor = textColor;
	for (UILabel *label in labels) {
		label.textColor = textColor;
	}
}

- (NSTextAlignment) textAlignment {
	return _textAlignment;
}

- (void) setTextAlignment:(NSTextAlignment)textAlignment {
	_textAlignment = textAlignment;
	
	for (UILabel *label in labels) {
		label.textAlignment = _textAlignment;
	}
}


- (void) setFrame:(CGRect)frame {
	//LOW - might need to do some more stuff here to handle this?
	_width = frame.size.width;
	[super setFrame:frame];
}
@end
