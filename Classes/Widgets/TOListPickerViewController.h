/*
 
 TOListPickerViewController
 
 ---
 
 Created by Jason Baker (jason@onejasonforsale.com)
 & Adam Zacharski (zacharski@gmail.com), Mar 2013.
 
 The latest version of this code is available here:
 
 - https://bitbucket.org/tumbleon/tumbleon-utils
 
 This code is licensed under the Apache license, a non-viral open source license
 that lets you use this code freely within your own projects without requiring
 your project itself to also be open source. More information about the Apache
 license is here:
 
 - http://en.wikipedia.org/wiki/Apache_license
 
 Copyright (c) 2013, Pocket Sized Giraffe, LLC. All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification,
 are permitted provided that the following conditions are met:
 
 1. Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 
 2. Redistributions in binary form must reproduce the above copyright notice, this
 list of conditions and the following disclaimer in the documentation and/or other
 materials provided with the distribution.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY
 EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 
 The views and conclusions contained in the software and documentation are those of
 the authors and should not be interpreted as representing official policies, either
 expressed or implied.
 
 */

#import <UIKit/UIKit.h>
#import "TOSimpleTableView.h"

@class TOListPickerViewController,TOListPickAddViewController;
@protocol TOListPickerDelegate <NSObject>
- (void) listPickerFinished:(TOListPickerViewController*)picker selectedItems:(NSMutableArray*)selectedItems;
@optional
- (void) itemWillBeRenamedAtIndex:(int)index itemOldName:(NSString*)itemOldName itemNewName:(NSString*)itemNewName;
- (void) itemAddedWithName:(NSString*)itemName;
- (void) itemDeletedWithName:(NSString*)itemName;
@end

@interface TOListPickerViewController : UIViewController <TOSimpleTableViewDelegate, UIAlertViewDelegate>
@property (strong,nonatomic) NSMutableArray * dataSource;
@property (strong,nonatomic) NSMutableArray * selectedItems;
@property (nonatomic) BOOL isEditable;
@property (nonatomic,weak) id<TOListPickerDelegate> delegate;
@property (strong,nonatomic) NSString * itemDescription;
@property BOOL multiSelectionAllowed;
@property (strong,nonatomic) UIBarButtonItem * doneButton;
@property (strong,nonatomic) UIBarButtonItem * editDoneButton;
@property (strong,nonatomic) UIBarButtonItem * editButton;
@property (strong,nonatomic) UIBarButtonItem * addButton;
@property (strong,nonatomic) IBOutlet UITableView * tableView;
@property (strong,nonatomic) TOSimpleTableView * tvh;
@property BOOL insideNavController;
@property (strong,nonatomic) TOListPickAddViewController * addViewController;
@property (strong,nonatomic) NSIndexPath * renamingIndexPath;
@property (strong,nonatomic) UITableViewCell * lastSelectedCell;
@end