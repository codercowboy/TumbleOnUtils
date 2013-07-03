//
//  ListPickerViewController.h
//  ReceiptKeeper
//
//  Created by Jason Baker on 3/1/13.
//  Copyright (c) 2013 Coder Cowboy, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewHelper.h"

@class ListPickerViewController,ListPickAddViewController;
@protocol ListPickerDelegate <NSObject>
- (void) listPickerFinished:(ListPickerViewController*)picker selectedItems:(NSMutableArray*)selectedItems;
@optional
- (void) itemWillBeRenamedAtIndex:(int)index itemOldName:(NSString*)itemOldName itemNewName:(NSString*)itemNewName;
- (void) itemAddedWithName:(NSString*)itemName;
- (void) itemDeletedWithName:(NSString*)itemName;
@end

@interface ListPickerViewController : UIViewController <TableHelperDelegate, UIAlertViewDelegate>
@property (strong,nonatomic) NSMutableArray * dataSource;
@property (strong,nonatomic) NSMutableArray * selectedItems;
@property (nonatomic) BOOL isEditable;
@property (nonatomic,weak) id<ListPickerDelegate> delegate;
@property (strong,nonatomic) NSString * itemDescription;
@property BOOL multiSelectionAllowed;
@property (strong,nonatomic) UIBarButtonItem * doneButton;
@property (strong,nonatomic) UIBarButtonItem * editDoneButton;
@property (strong,nonatomic) UIBarButtonItem * editButton;
@property (strong,nonatomic) UIBarButtonItem * addButton;
@property (strong,nonatomic) IBOutlet UITableView * tableView;
@property (strong,nonatomic) TableViewHelper * tvh;
@property BOOL insideNavController;
@property (strong,nonatomic) ListPickAddViewController * addViewController;
@property (strong,nonatomic) NSIndexPath * renamingIndexPath;
@property (strong,nonatomic) UITableViewCell * lastSelectedCell;
@end
