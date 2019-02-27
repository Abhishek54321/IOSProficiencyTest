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
#import "InfiniteScroller.h"
#import <QuartzCore/QuartzCore.h>

@interface InfiniteScroller ()

- (void)tileContentFromMinX:(CGFloat)minimumVisibleX toMaxX:(CGFloat)maximumVisibleX;
- (void)cacheNearbyViewsAndCleanUp;


@end


@implementation InfiniteScroller {
    NSMutableArray *_visibleItems;
    UIView *_containerView;
    CGFloat _offsetFromActual;
    __unsafe_unretained id <InfiniteScrollerDelegate> _infiniteScrollerDelegate;
    NSUInteger _numPages;
    BOOL _isInitialized;
    NSUInteger _currentPage;
    NSUInteger _lastSettledPageNum;
    BOOL _isAnimating;
    float _lastPageOffset;
}


- (id)initWithFrame:(CGRect)frame delegate:(id <InfiniteScrollerDelegate>)delegate numPages:(NSUInteger)aNumPages {
    if ((self = [super initWithFrame:frame])) {
        _infiniteScrollerDelegate = delegate;
        _numPages = aNumPages;
        _visibleItems = [[NSMutableArray alloc] init];
        _offsetFromActual = 0;
        _isInitialized = YES;
        _currentPage = 0;
        
        [self initializeProperties];
        [self buildContainer];
        
        //		if (_numPages == 1) {
        //			self.scrollEnabled = NO;
        //		}
        
        self.frame = frame;
    }
    return self;
}

- (void)initializeProperties {
    self.delegate = self;
    self.contentSize = CGSizeMake(5000, 0);
    self.pagingEnabled = YES;
    self.showsHorizontalScrollIndicator = NO;
}

- (void)buildContainer {
    _containerView = [[UIView alloc] init];
    _containerView.frame = CGRectMake(0, 0, self.contentSize.width, self.bounds.size.height);
    _containerView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self addSubview:_containerView];
}


#pragma mark -
#pragma mark Layout

- (CGFloat)centeredOffsetX {
    CGFloat centerOffsetX = (self.contentSize.width - self.bounds.size.width) / 2.0;
    //	NSLog(@"self.bounds.size.width = %f", self.bounds.size.width);
    //make sure the new offset is the same difference between pages as the old one
    CGFloat currentPageOffset = self.contentOffset.x - floorf(self.contentOffset.x / self.bounds.size.width) * self.bounds.size.width;
    centerOffsetX = floorf(centerOffsetX / self.bounds.size.width) * self.bounds.size.width + currentPageOffset;
    //	NSLog(@"centerOffsetX = %f", centerOffsetX);
    return centerOffsetX;
}

// recenter content periodically to achieve impression of infinite scrolling
- (void)recenterScrollView {
    CGPoint currentOffset = self.contentOffset;
    CGFloat centerOffsetX = [self centeredOffsetX];
    //	NSLog(@"centerOffsetX = %f", centerOffsetX);
    
    
    CGFloat diff = centerOffsetX - currentOffset.x;
    _offsetFromActual = _offsetFromActual + diff;
    
    self.contentOffset = CGPointMake(centerOffsetX, currentOffset.y);
    
    // move content by the same amount so it appears to stay still
    for (UIView *item in _visibleItems) {
        CGPoint center = [_containerView convertPoint:item.center toView:self];
        center.x += (centerOffsetX - currentOffset.x);
        item.center = [self convertPoint:center toView:_containerView];
    }
}

- (void)recenterIfNecessary {
    CGPoint currentOffset = self.contentOffset;
    CGFloat contentWidth = self.contentSize.width;
    CGFloat centerOffsetX = [self centeredOffsetX];
    
    CGFloat distanceFromCenter = fabs(currentOffset.x - centerOffsetX);
    
    if (distanceFromCenter > (contentWidth / 4.0)) {
        [self recenterScrollView];
        
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self recenterIfNecessary];
    
    // tile content in visible bounds
    CGRect visibleBounds = [self convertRect:[self bounds] toView:_containerView];
    CGFloat minimumVisibleX = CGRectGetMinX(visibleBounds);
    CGFloat maximumVisibleX = CGRectGetMaxX(visibleBounds);
    
    if (_numPages > 0) {
        [self tileContentFromMinX:minimumVisibleX toMaxX:maximumVisibleX];
        
        NSUInteger currentPage = [self pageIndexForX:self.contentOffset.x];
        if (currentPage != _currentPage) {
            _currentPage = currentPage;
            if ([_infiniteScrollerDelegate respondsToSelector:@selector(infiniteScrollerDidChangePage:)]) {
                [_infiniteScrollerDelegate infiniteScrollerDidChangePage:self];
            }
            float thisPageOffset = self.contentOffset.x - _offsetFromActual;
            if (thisPageOffset > _lastPageOffset) {
                if ([_infiniteScrollerDelegate respondsToSelector:@selector(infiniteScrollerDidPageToNext:)]) {
                    [_infiniteScrollerDelegate infiniteScrollerDidPageToNext:self];
                }
            } else {
                if ([_infiniteScrollerDelegate respondsToSelector:@selector(infiniteScrollerDidPageToPrev:)]) {
                    [_infiniteScrollerDelegate infiniteScrollerDidPageToPrev:self];
                }
            }
            _lastPageOffset = thisPageOffset;
        }
    }
}

- (void)removeVisibleItems {
    for (UIView *item in _visibleItems) {
        [item removeFromSuperview];
    }
    [_visibleItems removeAllObjects];
}

- (void)setFrame:(CGRect)aFrame {
    [super setFrame:aFrame];
    
    void (^layoutBlock)() = ^{
        
        //don't do this when the view is first initialized, before the init method is finished.
        if (_isInitialized) {
            [self removeVisibleItems];
            
            //zero the offset, so that the re-centering doesn't think the scrollView is between pages
            self.contentOffset = CGPointZero;
            [self setCurrentPage:_currentPage];
            [self cacheNearbyViewsAndCleanUp];
        }
    };
    
    //Fade the transition
    CATransition *transition = [CATransition animation];
    transition.duration = 0.25f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    [self.layer addAnimation:transition forKey:@"sizeChangeFadeAnimation"];
    
    [UIView animateWithDuration:0
                          delay:0
                        options:UIViewAnimationOptionOverrideInheritedDuration
                     animations:^{
                         layoutBlock();
                     } completion:nil];
    
}



#pragma mark -
#pragma mark Content Tiling

- (NSUInteger)pageIndexForX:(CGFloat)aFloat {
    NSInteger pageIndex = (NSInteger) roundf((aFloat - _offsetFromActual) / self.bounds.size.width);
    //TODO: better way of making sure the value is positive
    pageIndex += _numPages * 5000;
    NSUInteger normalizedIndex = _numPages <= 0 ? 0 : (NSUInteger) (pageIndex % _numPages);
    return normalizedIndex;
    
}

- (UIView *)insertItemAtX:(CGFloat)originX {
    NSUInteger index = [self pageIndexForX:originX];
    
    UIView *item = [_infiniteScrollerDelegate viewForIndex:index];
    item.frame = CGRectMake(originX, 0, self.bounds.size.width, self.bounds.size.height);
    
    [_containerView addSubview:item];
    
    return item;
}

- (CGFloat)placeNewItemOnRight:(CGFloat)rightEdge {
    UIView *item = [self insertItemAtX:rightEdge];
    [_visibleItems addObject:item]; // add rightmost item at the end of the array
    
    return CGRectGetMaxX(item.frame);
}

- (CGFloat)placeNewItemOnLeft:(CGFloat)leftEdge {
    UIView *item = [self insertItemAtX:leftEdge - self.frame.size.width];
    [_visibleItems insertObject:item atIndex:0]; // add leftmost item at the beginning of the array
    
    return CGRectGetMinX(item.frame);
}

- (void)removeExtraneousItemsOutsideMinX:(CGFloat)minimumVisibleX maximumVisibleX:(CGFloat)maximumVisibleX {
    
    UIView *lastItem, *firstItem;
    // remove items that have fallen off right edge
    lastItem = [_visibleItems lastObject];
    while ([lastItem frame].origin.x > maximumVisibleX) {
        [lastItem removeFromSuperview];
        [_visibleItems removeLastObject];
        lastItem = [_visibleItems lastObject];
    }
    
    // remove items that have fallen off left edge
    firstItem = [_visibleItems objectAtIndex:0];
    while (CGRectGetMaxX([firstItem frame]) < minimumVisibleX) {
        [firstItem removeFromSuperview];
        [_visibleItems removeObjectAtIndex:0];
        firstItem = [_visibleItems objectAtIndex:0];
    }
}

- (void)tileContentFromMinX:(CGFloat)minimumVisibleX toMaxX:(CGFloat)maximumVisibleX {
    // the upcoming tiling logic depends on there already being at least one item in the visibleItems array, so
    // to kick off the tiling we need to make sure there's at least one item
    if ([_visibleItems count] == 0) {
        [self placeNewItemOnRight:minimumVisibleX];
    }
    
    // add items that are missing on right side
    UIView *lastItem = [_visibleItems lastObject];
    CGFloat rightEdge = CGRectGetMaxX([lastItem frame]);
    while (rightEdge < maximumVisibleX) {
        rightEdge = [self placeNewItemOnRight:rightEdge];
    }
    
    // add items that are missing on left side
    UIView *firstItem = [_visibleItems objectAtIndex:0];
    CGFloat leftEdge = CGRectGetMinX([firstItem frame]);
    while (leftEdge > minimumVisibleX) {
        leftEdge = [self placeNewItemOnLeft:leftEdge];
    }
    
}

- (void)cacheNearbyViewsAndCleanUp {
    //	NSLog(@"%s", sel_getName(_cmd));
    CGRect visibleBounds = [self convertRect:[self bounds] toView:_containerView];
    CGFloat minX = CGRectGetMinX(visibleBounds) - self.frame.size.width;
    CGFloat maxX = CGRectGetMaxX(visibleBounds) + self.frame.size.width;
    if (_numPages > 0) {
        [self tileContentFromMinX:minX toMaxX:maxX];
        [self removeExtraneousItemsOutsideMinX:minX maximumVisibleX:maxX];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self cacheNearbyViewsAndCleanUp];
    
    
    NSUInteger settledPageNum = [self pageIndexForX:self.contentOffset.x];
    //	if (settledPageNum != _lastSettledPageNum) {
    _lastSettledPageNum = settledPageNum;
    if ([_infiniteScrollerDelegate respondsToSelector:@selector(infiniteScrollerDidSettleOnPage:)]) {
        [_infiniteScrollerDelegate infiniteScrollerDidSettleOnPage:self];
    }
    //	}
    
}




#pragma mark -


- (NSUInteger)currentPage {
    return _currentPage;
}

- (void)setCurrentPage:(NSUInteger)aCurrentPage {
    [self removeVisibleItems];
    
    _currentPage = aCurrentPage;
    //	NSLog(@"old _offsetFromActual = %f", _offsetFromActual);
    [self recenterScrollView];
    //	NSLog(@"after recentering: self.contentOffset.x = %f", self.contentOffset.x);
    
    CGFloat pageOffset = -(CGFloat) _currentPage * self.bounds.size.width;
    //	NSLog(@"pageOffset = %f", pageOffset);
    _offsetFromActual = pageOffset + self.contentOffset.x;
    //	NSLog(@"_offsetFromActual = %f", _offsetFromActual);
    [self setNeedsLayout];
    [self layoutIfNeeded];
    _lastPageOffset = self.contentOffset.x - _offsetFromActual;
}

- (void)animateScrollByX:(CGFloat)xOffset {
    //	[self removeVisibleItems];
    if (!_isAnimating) {
        [self recenterScrollView];
        CGFloat pageOffset = -(CGFloat) _currentPage * self.bounds.size.width;
        _offsetFromActual = pageOffset + self.contentOffset.x;
        [self setNeedsLayout];
        [self layoutIfNeeded];
        
        
        _isAnimating = YES;
        CGFloat targetX;
        if (xOffset > 0) {
            targetX = ceilf((self.contentOffset.x + xOffset) / self.bounds.size.width) * self.bounds.size.width;
        } else {
            targetX = floorf((self.contentOffset.x + xOffset) / self.bounds.size.width) * self.bounds.size.width;
        }
        [UIView animateWithDuration:0.25f animations:^{
            [self setContentOffset:CGPointMake(targetX, 0)];
            
        }                completion:^(BOOL finished) {
            _isAnimating = NO;
        }];
    }
}

- (void)animateToNextPage {
    [self animateScrollByX:self.bounds.size.width];
}

- (void)animateToPrevPage {
    [self animateScrollByX:-self.bounds.size.width];
}

- (UIView *)currentPageView {
    UIView *currentPageItem = nil;
    float distance = MAXFLOAT;
    for (UIView *item in _visibleItems) {
        float thisDistance = fabs(self.contentOffset.x - CGRectGetMinX(item.frame));
        if (thisDistance < distance) {
            currentPageItem = item;
            distance = thisDistance;
        }
    }
    return currentPageItem;
}


@end
