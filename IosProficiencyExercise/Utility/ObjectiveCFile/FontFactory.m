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
#import "FontFactory.h"

@implementation FontFactory

//TODO: fix all the trade gothics

+ (float)correctedSizeForSize:(float)size {
	float offset = kCFCoreFoundationVersionNumber >= 675 ? .0f : -1.5f;
	return MAX(size + offset, 9.0f);
}

+ (UIFont*)TradeGothicWithSize:(float)size {
	
	return [UIFont fontWithName:@"TradeGothicLTStd" size:[self correctedSizeForSize:size]];
}

+ (UIFont*)TradeGothicCn18WithSize:(float)size {
	
	return [UIFont fontWithName:@"TradeGothicLTStd-Cn18" size:[self correctedSizeForSize:size]];
}

+ (UIFont*)TradeGothicBoldWithSize:(float)size {
	return [UIFont fontWithName:@"TradeGothicLTStd-Bold" size:[self correctedSizeForSize:size]];
}

+ (UIFont*)TradeGothicBoldObliqueWithSize:(float)size {
	return [UIFont fontWithName:@"TradeGothicLTStd-BoldObl" size:[self correctedSizeForSize:size]];
}

+ (UIFont*)TradeGothicBoldCondensedWithSize:(float)size {
	
	return [UIFont fontWithName:@"TradeGothicLTStd-BdCn20" size:[self correctedSizeForSize:size]];
}

+ (UIFont*)KnockoutHTF28JuniorFeatherwtWithSize:(float)size {
    
    return [UIFont fontWithName:@"Knockout-HTF28-JuniorFeatherwt" size:[self correctedSizeForSize:size]];
}

+ (UIFont*)KnockoutHTF27JuniorBantamwtWithSize:(float)size {
    
    return [UIFont fontWithName:@"Knockout-HTF27-JuniorBantamwt" size:[self correctedSizeForSize:size]];
}

+ (UIFont*)GothamBookWithSize:(float)size {
    
    return [UIFont fontWithName:@"Gotham-Book" size:[self correctedSizeForSize:size]];
}

+ (UIFont*)GothamLightWithSize:(float)size {
    
    return [UIFont fontWithName:@"Gotham-Light" size:[self correctedSizeForSize:size]];
}

+ (UIFont*)GothamMediumWithSize:(float)size {
    
    return [UIFont fontWithName:@"Gotham-Medium" size:[self correctedSizeForSize:size]];
}

+ (UIFont*)TradeGothicBold2WithSize:(float)size {
	return [UIFont fontWithName:@"TradeGothicLTStd-Bd2" size:[self correctedSizeForSize:size]];
}

+ (UIFont*)TradeGothicObl2WithSize:(float)size {
	return [UIFont fontWithName:@"TradeGothicLTStd-Obl" size:[self correctedSizeForSize:size]];
}

+ (UIFont*)helveticaNeueuLtStdWithSize:(float)size {
	UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Light" size:[self correctedSizeForSize:size]];
	if (!font) font = [UIFont fontWithName:@"HelveticaNeue" size:[self correctedSizeForSize:size]];

	return font;
}

+ (UIFont*)helveticaNeueuLtStdBoldWithSize:(float)size {
	return [UIFont fontWithName:@"HelveticaNeue-Bold" size:[self correctedSizeForSize:size]];
}

@end
