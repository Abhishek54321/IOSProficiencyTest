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
#import "KnNumberUtils.h"

@implementation KnNumberUtils

+(NSInteger)timeSecondDifferenceFrom:(NSDate*)dateA to:(NSDate*)dateB
{
	NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
	NSDateComponents *components = [calendar components:NSCalendarUnitSecond fromDate:dateA toDate:dateB options:0];
	
	return components.second;
}

@end
