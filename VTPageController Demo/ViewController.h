//
//  ViewController.h
//  VTPageController Demo
//
//  Created by Vince Tagle on 7/31/13.
//  Copyright (c) 2013 Malarkey Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VXTPageControl;

@interface ViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, weak) IBOutlet UIScrollView* scrollView;
@property (nonatomic, weak) IBOutlet VXTPageControl* pageControl;
@property (nonatomic, strong) IBOutlet UIView* contentsView;

@end
