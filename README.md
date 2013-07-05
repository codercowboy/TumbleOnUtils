TumbleOnUtils
==============

A collection of objective-c IOS utilities written by the development team behind TumbleOn. 

* Authors: 
    * Jason Baker ([jason@onejasonforsale.com](mailto:jason@onejasonforsale.com)) 
    * Adam Zacharski ([zacharski@gmail.com](mailto:zacharski@gmail.com))
* On github: [https://github.com/codercowboy/TumbleOnUtils](https://github.com/codercowboy/TumbleOnUtils)
* More info: [http://www.tumbleonapp.com/code](http://www.tumbleonapp.com)

Basic Instructions
==================

These utility classes were created for TumbleOn, our Tumblr client for iPad and iPhone, and other products we've created.

You can easily include these utilities within your own project by downloading this repo, adding the files under "TumbleOnUtils" to your IOS project, and adding the following line to your project:

    #import "TumbleOnUtils.h"

Many of the utility classes have examples of usage in comments, and several have associated example implementation classes.

TumbleOnUtils is also available as a [CocoaPod](http://cocoapods.org/?q=tumble). CocoaPods are like a simplified version of Maven's dependency management, but for IOS. You can find many more great IOS libraries through CocoaPods, and easily add them to your project.  

What the code does
==================


DATA STRUCTURES
* Foundation+TONilSafe - arrays, dictionaries, and strings with nil-safe add operations
* Foundation+TO - various utilities for Foundation classes
* TOGrid - 2D grid implementation, for games
* TOLinkedList - simple linked list implementation
* NSCollections+TO - various utilities for arrays and dictionaries
* TOOperationManager - fixed capacity operation queue with weak or strong target pointers
* TOWrappers - simple classes wrapping a mutable primitive value or a weak object

UIKIT

* TOFrameUtils - simplifies CGRect frame operations
* TOSimpleTableView - simplifies UITableViewDelegate implementation
* TOUIKeyboardListener - simplifies working with UIKeyboard
* UIKit+TO - various utilities for UIKit classes
* UIView+TOFrameUtils - simplifies CGRect frame operations
* UIViewController+TO - various utilities for UIViewControllers
* UIWebView+TOClean.h - simplifies proper UIWebView cleanup before dealloc

WIDGETS

* TOBorderView - configurable top/bottom/left/right border view
* TOCurrencyTextField - self-contained UITextField that accepts US currency
* TODatePickerViewController - self-contained UITextField with +/- stepper and associated date picker
* TOListPickerViewController - self-containted UITableViewController to select/reorder/add/delete/rename items from a list
* TOTouchDelegatorView - UIView that delegates all touch events (and long press gestures) to a delegate
* UIKit+TOFlashing.h - UILabel or UIView w/ flashing timer

MISC

* TOFileUtil - file IO and filename related utilities.
* TOSimpleImagePicker - simplifies working with UIImagePickerController
* TOSimpleMailer - simplifies working with MFMailComposeViewController
* UIImage+TO - image utils such as resize


Other great libraries and resources
===================================

You can find many more great IOS libraries through [CocoaPods](http://cocoapods.org/?q=tumble), and easily add them to your project.  


We highly recommend these great IOS libraries:

* [ASIHTTPRequest](http://allseeing-i.com/ASIHTTPRequest/) - http library, sync and async
* [Flurry](http://www.flurry.com/) - analytics
* [LumberJack](https://github.com/robbiehanson/CocoaLumberjack) - logging
* [MKBadgeNumberView](https://github.com/michaelkamprath/iPhoneMK/tree/master/Views/MKNumberBadgeView) - badge views
* [NSString+HTML](https://github.com/mwaterfall/MWFeedParser/tree/master/Classes) and [GTMNSString+HTML](http://code.google.com/p/google-toolbox-for-mac/source/browse/trunk/Foundation/?r=314) - html encoding/decoding
* [QuincyKit](http://quincykit.net/) - crash reporting
* [RegexKitLite](http://regexkit.sourceforge.net/RegexKitLite/) - Regex functions
* [TBXML](http://www.tbxml.co.uk/TBXML/TBXML_Free.html) - xml parser
* [UIColor Utilities](http://arstechnica.com/apple/2009/02/iphone-development-accessing-uicolor-components/) - great color utils, i.e.: colorWithHexString

A variety of other iOS development resources are listed on another project we run: [The Objective Sea](http://www.theobjectivesea.com)

Notes
=====

If you have any questions, comments, kudos, criticisms about any of the code, e-mail us. 

All code in this library uses [Automatic Reference Counting (ARC)](http://developer.apple.com/library/mac/#releasenotes/ObjectiveC/RN-TransitioningToARC/Introduction/Introduction.html), which is available (and preferred) in IOS6+. 

Licensing
=========

TumbleOnUtils is licensed with the [Apache license](http://en.wikipedia.org/wiki/Apache_license), which is a great license because, essentially it:

* covers liability - our code should work, but we're not liable if you do something stupid with it
* allows you to copy, fork, and use the code, even commercially
* is [non-viral](http://en.wikipedia.org/wiki/Viral_license), that is, your derivative code doesn't *have to be* open source to use it

Other great licensing options for your own code: the BSD License, or the MIT License.

Here's the license:

Copyright (c) 2012, Pocket Sized Giraffe, LLC. All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
* 1. Redistributions of source code must retain the above copyright notice, this
list of conditions and the following disclaimer.
* 2. Redistributions in binary form must reproduce the above copyright notice,
this list of conditions and the following disclaimer in the documentation
and/or other materials provided with the distribution.
  
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  
The views and conclusions contained in the software and documentation are those
of the authors and should not be interpreted as representing official policies,
either expressed or implied.
