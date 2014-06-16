VXTPageControl
==============

`VXTPageControl` is a drop-in replacement for UIPageControl that supports customizable images. 

##Supported Platforms

- iOS 6+

##Installation

Drop in the following two files into your project to use `VXTPageControl`: 

- `VXTPageControl.h`
- `VXTPageControl.m`

Once added, `VXTPageControl` can be used anywhere you would normally use a [`UIPageControl`](https://developer.apple.com/library/ios/documentation/uikit/reference/uipagecontrol_class/Reference/Reference.html) and is written to be a drop-in replacement. It implements all of `UIPageControl` methods with the exception of: 

- pageIndicatorTintColor
- currentPageIndicatorTintColor

`VXTPageControl` can be safely compiled with or without ARC enabled.

##Usage

Please refer to the example project for a sample of how `VXTPageControl` can be used. Generally, you can either add it in code or via InterfaceBuilder. Properties of `VXTPageControl` need to be set in code, however, as there's no currently no support for setting them directly through InterfaceBuilder. 

````
VXTPageControl* _pageControl = ...; 
_pageControl.numberOfPages = 4;
_pageControl.currentPage = 0;
_pageControl.activeImage = [UIImage imageNamed: @"page_active"];
_pageControl.inactiveImage = [UIImage imageNamed: @"page_inactive"];
[_pageControl addTarget: self 
                 action: @selector(pageControlValueChanged:) 
       forControlEvents: UIControlEventValueChanged];
````

##License

`VXTPageControl` is licensed under the MIT license, which is reproduced in its entirety here:

>Copyright (c) 2014 Vince Tagle
>
>Permission is hereby granted, free of charge, to any person obtaining a copy
>of this software and associated documentation files (the "Software"), to deal
>in the Software without restriction, including without limitation the rights
>to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
>copies of the Software, and to permit persons to whom the Software is
>furnished to do so, subject to the following conditions:
>
>The above copyright notice and this permission notice shall be included in
>all copies or substantial portions of the Software.
>
>THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
>AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
>LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
>OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
>THE SOFTWARE.
