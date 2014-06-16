//
//  VTPageControl.m
//  VTPageControl
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

#import "VXTPageControl.h"

@implementation VXTPageControl

- (id)init
{
	self = [self initWithFrame: CGRectZero];
	
	return self;
}

- (id)initWithFrame:(CGRect)frame
{
	if ( (self = [super initWithFrame: CGRectZero]) )
	{
		self.backgroundColor = [UIColor clearColor];
		_spaceBetweenIndicators = 12.0f;
	}
	
	return self;
}

- (id)initWithCoder: (NSCoder *)aDecoder
{
	self = [super initWithCoder: aDecoder];
	if ( self )
	{
		_spaceBetweenIndicators = 12.0f;
	}
	
	return self; 
}

- (void)dealloc 
{
#if !__has_feature(objc_arc)
	[super dealloc];
#endif
}

#pragma mark - drawRect

- (void)drawRect: (CGRect)rect 
{
	// The diameter is taken from the larger of the two images.
	//
	CGFloat diameter = MAX(_activeImage.size.width, _inactiveImage.size.width);
	
	// Do some math to figure out where to draw the images for the dots.
	// 
	CGRect currentBounds = self.bounds;
	CGFloat dotsWidth = _numberOfPages * diameter + MAX(0, _numberOfPages - 1) * _spaceBetweenIndicators;
	CGFloat x = CGRectGetMidX(currentBounds) - dotsWidth / 2;
	CGFloat y = CGRectGetMidY(currentBounds) - diameter / 2;
	
	// Draw the dots based on the active and inactive pages.
	// 
	int i;
	for (i = 0 ; i < _numberOfPages ; i++)
	{
		CGRect dotRect = CGRectMake(x, y, diameter, diameter);
		
		if ( i == _currentPage )
		{
			[_activeImage drawInRect: dotRect];
		}
		else
		{
			[_inactiveImage drawInRect: dotRect];
		}
		
		x += diameter + _spaceBetweenIndicators;
	}
}


#pragma mark - Accessors

- (void)setCurrentPage: (NSInteger)pageNumber
{
	if ( _currentPage != pageNumber )
	{
		// Clamp the new page number to our range.
		//
		_currentPage = MIN(MAX(0, pageNumber), _numberOfPages - 1);
		
		if ( _defersCurrentPageDisplay == NO )
		{
			[self setNeedsDisplay];
		}
	}
}

- (void)setNumberOfPages: (NSInteger)numOfPages
{
	// Make sure the number of pages is reasonable and also clamp our current page number to it.
	//
	_numberOfPages = MAX(0, numOfPages);
	_currentPage = MIN(_currentPage, _numberOfPages - 1);
	
	[self setNeedsDisplay];
	
	if ( _hidesForSinglePage && _numberOfPages < 2 )
	{
		self.hidden = YES;
	}
	else
	{
		self.hidden = NO;
	}
}

- (void)setHidesForSinglePage: (BOOL)hide
{
	_hidesForSinglePage = hide;
	
	if ( _hidesForSinglePage && _numberOfPages < 2 )
	{
		self.hidden = YES;
	}
	else
	{
		self.hidden = NO;
	}
}

- (void)setSpaceBetweenIndicators: (CGFloat)space
{
	_spaceBetweenIndicators = space;
	
	[self setNeedsDisplay];
}

- (void)setActiveImage: (UIImage *)activeImage
{
#if !__has_feature(objc_arc)
	[activeImage retain];
	[_activeImage release];
#endif
	
	_activeImage = activeImage;
	[self setNeedsDisplay]; 
}

- (void)setInactiveImage: (UIImage *)inactiveImage
{
#if !__has_feature(objc_arc)
	[inactiveImage retain];
	[_inactiveImage release];
#endif
	
	_inactiveImage = inactiveImage;
	[self setNeedsDisplay];
}

#pragma mark - UIPageControl methods

- (void)updateCurrentPageDisplay
{
	if ( _defersCurrentPageDisplay )
	{
		[self setNeedsDisplay];
	}
}

- (CGSize)sizeForNumberOfPages: (NSInteger)pageCount
{
	CGFloat diameter = MAX(_activeImage.size.width, _inactiveImage.size.width);
	
	return CGSizeMake(_numberOfPages * diameter + MAX(0, _numberOfPages - 1) * _spaceBetweenIndicators, diameter);
}


#pragma mark - Touches handlers

- (void)touchesEnded: (NSSet *)touches withEvent: (UIEvent *)event
{
	// Get the touch location.
	//
	CGPoint touchLocation = [[touches anyObject] locationInView: self];
	
	// Check whether the touch is in the right or left hand-side of the control.
	//
	if ( touchLocation.x < (self.bounds.size.width / 2) )
	{
		_currentPage = MAX(_currentPage - 1, 0);
	}
	else
	{
		_currentPage = MIN(_currentPage + 1, _numberOfPages - 1);
	}
	
	if ( _defersCurrentPageDisplay == NO )
	{
		[self setNeedsDisplay];
	}
	
	// Send the value changed action to the target.
	//
	[self sendActionsForControlEvents: UIControlEventValueChanged];
}

@end
