//
//  ListPickerViewController.m
//  ReceiptKeeper
//
//  Created by Jason Baker on 3/1/13.
//  Copyright (c) 2013 Coder Cowboy, LLC. All rights reserved.
//

#import "ListPickerViewController.h"
#import "ListPickAddViewController.h"
#import "UIKit+TO.h"
#import "UIViewController+TO.h"

@interface ListPickerTableViewCell : UITableViewCell
@property (strong,nonatomic) UIButton * renameButton;
@property (weak,nonatomic) NSObject * renameTarget;
@property (nonatomic) SEL renameAction;
@end

@implementation ListPickerTableViewCell

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.editing) {
        if (self.renameButton == nil) {
            self.renameButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            self.renameButton.frame = CGRectMake(160,10,65,25);
            self.renameButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
            [self.renameButton setTintColor:[UIColor grayColor]];
            [self.renameButton setTitle:@"Rename" forState:UIControlStateNormal];
            [self.renameButton addTarget:self action:@selector(rename) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:self.renameButton];
        }
        self.renameButton.hidden = NO;
    } else {
        self.renameButton.hidden = YES;
    }

}

- (void) rename {
    [self.renameTarget performSelector:self.renameAction withObject:self];
}

@end


@interface ListPickerViewController ()
@end

@implementation ListPickerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.selectedItems = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.doneButton == nil) {
        self.doneButton = BarButtonItem(@"Done", @selector(done));
    }
    if (self.editDoneButton == nil) {
        self.editDoneButton = BarButtonItem(@"Done", @selector(edit));
    }
    if (self.editButton == nil) {
        self.editButton = BarButtonItem(@"Edit", @selector(edit));
    }
    if (self.addButton == nil) {
        self.addButton =  BarButtonItem(@"Add", @selector(add));
    }

    self.navigationItem.rightBarButtonItem = self.doneButton;
    if (self.isEditable) {
        self.navigationItem.leftBarButtonItem = self.editButton;
    }
    self.navigationItem.title = self.itemDescription;
    self.tvh = [TableViewHelper createTableViewHelper:self.tableView dataSource:self.dataSource delegate:self];
    self.tvh.allowEdits = self.isEditable;
}

- (void) edit {
    [self.tableView setEditing:!self.tableView.editing];
    self.navigationItem.leftBarButtonItem = self.tableView.editing ?  self.editDoneButton : self.editButton;
    self.navigationItem.rightBarButtonItem = self.tableView.editing ? self.addButton : self.doneButton;
}

- (void)viewWillAppear:(BOOL)animated {
    if (self.addViewController != nil) {
        if (self.addViewController.itemNewName != nil) {
            NSString * itemNewName = self.addViewController.itemNewName;
            if (self.addViewController.itemName != nil) { //rename
                int index = self.renamingIndexPath.row;
                NSString * itemOldName = [self.dataSource objectAtIndex:index];
                if ([self.delegate respondsToSelector:@selector(itemWillBeRenamedAtIndex:itemOldName:itemNewName:)]) {
                    [self.delegate itemWillBeRenamedAtIndex:index itemOldName:itemOldName itemNewName:itemNewName];
                }
                [self.dataSource replaceObjectAtIndex:index withObject:itemNewName];
                if ([self.selectedItems containsObject:itemOldName]) {
                    int index = [self.selectedItems indexOfObject:itemOldName];
                    [self.selectedItems replaceObjectAtIndex:index withObject:itemNewName];
                }
            } else { //add
                [self.dataSource addObject:itemNewName];
                if ([self.delegate respondsToSelector:@selector(itemAddedWithName:)]) {
                    [self.delegate itemAddedWithName:itemNewName];
                }
            }
        }
        self.renamingIndexPath = nil;
        self.addViewController = nil;
    }
    [self.tableView reloadData];
}

- (void) renameItem:(id)sender {
    ListPickerTableViewCell * cell = (ListPickerTableViewCell *) sender;
    self.renamingIndexPath = [self.tableView indexPathForCell:cell];
    ListPickAddViewController * lpavc = (ListPickAddViewController *) vcFromNib(@"ListPickAddViewController");
    lpavc.itemDescription = self.itemDescription;
    lpavc.itemName = [self.dataSource objectAtIndex:self.renamingIndexPath.row];
    self.addViewController = lpavc;
    lpavc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self pushModalAnimated:lpavc];
}

- (void) add {
    ListPickAddViewController * lpavc = (ListPickAddViewController *) vcFromNib(@"ListPickAddViewController");
    lpavc.itemDescription = self.itemDescription;
    self.addViewController = lpavc;
    lpavc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self pushModalAnimated:lpavc];
}

- (UITableViewCell *)createCellForObject:(NSObject *)object {
    ListPickerTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"id"];
    if (cell == nil) {
        cell = [[ListPickerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id"];
        cell.renameTarget = self;
        cell.renameAction = @selector(renameItem:);
    }
    cell.textLabel.text =  (NSString*)object;
    if ([self.selectedItems containsObject:object]) {
        [self objectSelected:cell.textLabel.text cell:cell];
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)objectSelected:(NSObject *)object cell:(UITableViewCell *)cell {
    if (self.multiSelectionAllowed) {
        if ([self.selectedItems containsObject:object]) {
            [self.selectedItems removeObject:object];
            cell.accessoryType = UITableViewCellAccessoryNone;
        } else {
            [self.selectedItems addObject:object];
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    } else {
        [self.selectedItems removeAllObjects];
        [self.selectedItems addObject:object];
        self.lastSelectedCell.accessoryType = UITableViewCellAccessoryNone;
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        self.lastSelectedCell = cell;
    }
}

- (void) done {
    [self.delegate listPickerFinished:self selectedItems:self.selectedItems];
}

- (void)objectDeleted:(NSObject *)object {
    if ([self.delegate respondsToSelector:@selector(itemDeletedWithName:)]) {
        [self.delegate itemDeletedWithName:(NSString*)object];
    }
}

- (void) clearAll {
    NSString * message = [NSString stringWithFormat:@"Remove all %@ items?", self.itemDescription];
    [UIAlertView showSimpleNoYesAlert:message alertViewDelegate:self];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    //clear all was tapped
    if (buttonIndex == 1) {
        [self.dataSource removeAllObjects];
        [self.tvh reload];
        [self edit];
    }
}


@end
