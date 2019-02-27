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
@interface NavBarButton : UIBarButtonItem

+ (NavBarButton *)backButtonWithText:(NSString *)text navController:(UINavigationController *)navController;
+ (NavBarButton *)buttonWithText:(NSString *)text;

- (id)initWithText:(NSString *)text image:(UIImage *)image imageHighlighted:(UIImage *)imageHighlight edgeInsets:(UIEdgeInsets)edgeInsets;

- (id)initWithText:(NSString *)text image:(UIImage *)image edgeInsets:(UIEdgeInsets)edgeInsets;

- (id)initWithText:(NSString *)text textColor:(UIColor *)aTextColor image:(UIImage *)image edgeInsets:(UIEdgeInsets)edgeInsets;

- (NavBarButton *)initBackButtonWithNavController:(UINavigationController *)navController;


- (void)addTarget:(id)target action:(SEL)sel forControlEvents:(UIControlEvents)controlEvent;

- (void)setText:(NSString *)string;
@property(nonatomic) BOOL userInteractionEnabled;

@property(nonatomic, strong) void (^block)();
@end
