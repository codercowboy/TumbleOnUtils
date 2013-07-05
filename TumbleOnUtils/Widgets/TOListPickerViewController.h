/*
 
 TOListPickerViewController
 
 ---
 
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
