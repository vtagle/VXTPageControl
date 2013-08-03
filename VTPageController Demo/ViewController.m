//
//  ViewController.m
//  VTPageController Demo
//
//  Created by Vince Tagle on 7/31/13.
//  Copyright (c) 2013 Malarkey Software. All rights reserved.
//

#import "ViewController.h"
#import "VTPageControl.h"

@interface ViewController ()

- (void)pageControlValueChanged: (id)sender;

@end

@implementation ViewController
{
	CGPoint previousContentOffset;
	BOOL	pageControlValueChanged;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	for (UIView* subview in _contentsView.subviews)
	{
		subview.frame = CGRectMake(subview.frame.origin.x,
								   subview.frame.origin.y,
								   subview.frame.size.width,
								   _scrollView.frame.size.height);
	}
	
	_scrollView.contentSize = _contentsView.frame.size;
	[_scrollView addSubview: _contentsView];
	
	_pageControl.numberOfPages = 4;
	_pageControl.currentPage = 0;
	_pageControl.activeImage = [UIImage imageNamed: @"page_active"];
	_pageControl.inactiveImage = [UIImage imageNamed: @"page_inactive"];
	[_pageControl addTarget: self action: @selector(pageControlValueChanged:) forControlEvents: UIControlEventValueChanged];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark UIScrollView Delegate

- (void)scrollViewDidScroll: (UIScrollView *)scrollView
{
	if ( pageControlValueChanged == NO )
	{
		if ( scrollView.contentOffset.x > ( previousContentOffset.x + scrollView.frame.size.width / 2 ) )
		{
			_pageControl.currentPage = ( previousContentOffset.x + scrollView.frame.size.width ) / scrollView.frame.size.width;
		}
		else if ( scrollView.contentOffset.x < ( previousContentOffset.x - scrollView.frame.size.width / 2 ) )
		{
			_pageControl.currentPage = (previousContentOffset.x / scrollView.frame.size.width) - 1;
		}
	}
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
	previousContentOffset = scrollView.contentOffset;
	_pageControl.currentPage = previousContentOffset.x / scrollView.frame.size.width;
	
	if ( pageControlValueChanged )
	{
		pageControlValueChanged = NO;
	}
}

#pragma mark -

- (void)pageControlValueChanged: (id)sender
{
	pageControlValueChanged = YES;
	
	CGPoint contentOffset = CGPointMake(_pageControl.currentPage * _scrollView.frame.size.width, 0.0f);
	[_scrollView setContentOffset: contentOffset animated: YES];
}

@end
