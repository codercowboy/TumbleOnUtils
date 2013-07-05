/*
 
 TumbleOnUtils header file
  
 This code comes from TumbleOnUtils, which is an open-source collection of
 iOS utilities developed for TumbleOn and other projects.
 
 https://github.com/codercowboy/TumbleOnUtils/
 
 Authors
 * Jason Baker (jason@onejasonforsale.com)
 * Adam Zacharski (zacharski@gmail.com)
 
 TumbleOnUtils is licensed with the Apache license. For details, see:
 
 https://github.com/codercowboy/TumbleOnUtils/blob/master/LICENSE.md
 
 Copyright (c) 2012-2013, Pocket Sized Giraffe, LLC. All rights reserved.
 
 */

/*******************
 * DATA STRUCTURES *
 *******************/

#import "Foundation+TONilSafe.h" //arrays, dictionaries, and strings with nil-safe add operations
#import "Foundation+TO.h" //various utilities for Foundation classes
#import "TOGrid.h" //2D grid implementation, for games
#import "TOLinkedList.h" //simple linked list implementation
#import "NSCollections+TO.h" //various utilities for arrays and dictionaries
#import "TOOperationManager.h" //fixed capacity operation queue with weak or strong target pointers
#import "TOWrappers.h" //simple classes wrapping a mutable primitive value or a weak object

/********
 * MISC *
 ********/

#import "TOFileUtil.h" //file IO and filename related utilities.
#import "TOSimpleImagePicker.h" //simplifies working with UIImagePickerController
#import "TOSimpleMailer.h" //simplifies working with MFMailComposeViewController
#import "UIImage+TO.h" //image utils such as resize

/*********
 * UIKIT *
 *********/

#import "TOFrameUtils.h" //simplifies CGRect frame operations
#import "TOSimpleTableView.h" //simplifies UITableViewDelegate implementation
#import "TOUIKeyboardListener.h" //simplifies working with UIKeyboard
#import "UIKit+TO.h" //various utilities for UIKit classes
#import "UIView+TOFrameUtils.h" //simplifies CGRect frame operations
#import "UIViewController+TO.h" //various utilities for UIViewControllers
#import "UIWebView+TOClean.h" //simplifies proper UIWebView cleanup before dealloc

/****************
 * WIDGETS *
 ***********/

#import "TOBorderView.h" //configurable top/bottom/left/right border view
#import "TOCurrencyTextField.h" //self-contained UITextField that accepts US currency
#import "TODatePickerViewController.h" //self-contained UITextField with +/- stepper and associated date picker
#import "TOListPickerViewController.h" //self-containted UITableViewController to select/reorder/delete/rename items from a list
#import "TOListPickAddViewController.h" //add item controller for ListPickerViewController
#import "TOTouchDelegatorView.h" //UIView that delegates all touch events (and long press gestures) to a delegate
#import "UIKit+TOFlashing.h" //UILabel or UIView w/ flashing timer
