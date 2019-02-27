/*
 
 This is heavily based on Apple's StreetScroller example code
 http://developer.apple.com/library/ios/#samplecode/StreetScroller/Introduction/Intro.html
 
 */

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
@protocol InfiniteScrollerDelegate;


@interface InfiniteScroller : UIScrollView <UIScrollViewDelegate>
@property(nonatomic, assign) NSUInteger currentPage;


- (id)initWithFrame:(CGRect)frame delegate:(id <InfiniteScrollerDelegate>)delegate numPages:(NSUInteger)aNumPages;
- (void)animateToPrevPage;

- (void)animateToNextPage;

- (UIView *)currentPageView;


@end

@protocol InfiniteScrollerDelegate <NSObject>

- (UIView *)viewForIndex:(NSUInteger)index;

@optional
- (void)infiniteScrollerDidSettleOnPage:(InfiniteScroller *)scroller;
- (void)infiniteScrollerDidChangePage:(InfiniteScroller *)scroller;

- (void)infiniteScrollerDidPageToNext:(InfiniteScroller *)scroller;
- (void)infiniteScrollerDidPageToPrev:(InfiniteScroller *)scroller;

//TODO:
- (void)infiniteScrollerDidUpdateScrollPercentage:(InfiniteScroller *)scroller;

@end
