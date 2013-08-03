//
//  ViewController.h
//  VTPageController Demo
//
//  Created by Vince Tagle on 7/31/13.
//  Copyright (c) 2013 Malarkey Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VTPageControl;

@interface ViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, weak) IBOutlet UIScrollView* scrollView;
@property (nonatomic, weak) IBOutlet VTPageControl* pageControl;
@property (nonatomic, strong) IBOutlet UIView* contentsView;

@end
