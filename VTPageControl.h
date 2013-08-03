//
//  VTPageControl.h
//  VTPageControl
//
//  Created by Vince Tagle on 4/22/13.
//  Copyright 2013 Vince Tagle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIControl.h>
#import <UIKit/UIKitDefines.h>

@interface VTPageControl : UIControl

/*
 Replicate the original functions from UIPageControl. 
 */
@property(nonatomic) NSInteger numberOfPages;
@property(nonatomic) NSInteger currentPage;
@property(nonatomic) BOOL hidesForSinglePage;
@property(nonatomic) BOOL defersCurrentPageDisplay;

- (void)updateCurrentPageDisplay;
- (CGSize)sizeForNumberOfPages: (NSInteger)pageCount;

@property (nonatomic, assign) CGFloat spaceBetweenIndicators; 
@property (nonatomic, strong) UIImage* activeImage;
@property (nonatomic, strong) UIImage* inactiveImage;

@end

