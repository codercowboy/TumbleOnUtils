/*
 
 TOSimpleTableView
 
 A wrapper class to simplify UITableViewDelegate implementation.
 
 USAGE INSTRUCTIONS
 
 See the TableViewHelperExample.h and .m files for example usage.
 
 Using TableViewHelper is simpler than implementing the same-old
 UITableViewDelegate methods and implementations over and over again.
 
 TableViewHelper creates a single section table out of a NSMutableArray
 data source that you provide. This wrapper is not the end-all/be-all
 wrapper that's perfect for every UITableView situation, but it works
 well in most simple cases.
 
 You simply implement TableHelperDelegate methods in the class that will
 own the TableViewHelper instance (usually the same class that owns the
 underlying UITableView), and wrap your TableViewHelper instance around
 your UITableView.
 
 TableViewHelper will make itself your UITableView's delegate target, and
 delegate simplified operations to you, while managing some of the basic
 operations like editable table items for you.
 
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

#import <Foundation/Foundation.h>

@protocol TOSimpleTableViewDelegate <NSObject>
@required
/* Create and return a UITableViewCell instance for the given object from your data source. */
- (UITableViewCell *) createCellForObject:(NSObject *)object;
/* Perform an action based on the given selected object from your data source. */
/* Provided cell object is the cell you've wrapped around the object. */
- (void) objectSelected:(NSObject *)object cell:(UITableViewCell *)cell;
@optional
/* Optional method to perform an action when the given item is removed from your data source */
- (void) objectDeleted:(NSObject *)object;
@end

@interface TOSimpleTableView : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (strong) UITableView * myTableView;
@property (strong) NSMutableArray * dataSource;
@property BOOL allowEdits;
@property (weak) id delegate;

+ (TOSimpleTableView *) createTableViewHelper:(UITableView *)tableView dataSource:(NSMutableArray *)dataSource delegate:(id)delegate;

- (void) reload;

@end