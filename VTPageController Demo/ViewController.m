//
//  ViewController.m
//  VTPageController Demo
//
// The MIT License (MIT)
// 
// Copyright (c) 2014 vtagle
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#import "ViewController.h"
#import "VXTPageControl.h"

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
