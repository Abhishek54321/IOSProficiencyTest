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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FontFactory : NSObject

+ (UIFont*)TradeGothicWithSize:(float)size;
//+ (UIFont*)TradeGothicRealWithSize:(float)size;
+ (UIFont*)TradeGothicCn18WithSize:(float)size;
+ (UIFont*)TradeGothicBoldWithSize:(float)size;
+ (UIFont*)TradeGothicBoldObliqueWithSize:(float)size;
+ (UIFont*)TradeGothicBoldCondensedWithSize:(float)size;
+ (UIFont*)TradeGothicBold2WithSize:(float)size;
+ (UIFont*)TradeGothicObl2WithSize:(float)size;

+ (UIFont*)helveticaNeueuLtStdWithSize:(float)size;
+ (UIFont*)helveticaNeueuLtStdBoldWithSize:(float)size;

+ (UIFont*)KnockoutHTF28JuniorFeatherwtWithSize:(float)size;
+ (UIFont*)KnockoutHTF27JuniorBantamwtWithSize:(float)size;
+ (UIFont*)GothamBookWithSize:(float)size;
+ (UIFont*)GothamLightWithSize:(float)size;
+ (UIFont*)GothamMediumWithSize:(float)size;

@end
