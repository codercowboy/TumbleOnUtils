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
#import <UIKit/UIKit.h>

@class TOSimpleTableView;
@protocol TOSimpleTableViewDelegate <NSObject>
@optional
/* Create and return a UITableViewCell instance for the given object from your data source. */
- (UITableViewCell *) toSimpleTableView:(TOSimpleTableView*)simpleTableView createCellForObject:(NSObject *)object index:(int)index;
/* Perform an action based on the given selected object from your data source. */
/* Provided cell object is the cell you've wrapped around the object. */
- (void) toSimpleTableView:(TOSimpleTableView*)simpleTableView objectSelected:(NSObject *)object index:(int)index cell:(UITableViewCell *)cell;
/* Optional method to perform an action when the given item is removed from your data source */
- (void) toSimpleTableView:(TOSimpleTableView*)simpleTableView objectDeleted:(NSObject *)object index:(int)index;
@end

@interface TOSimpleTableView : NSObject <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, readonly) NSString * defaultCellIdentifier;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * dataSource;
@property (nonatomic) BOOL allowEdits;
@property (nonatomic, weak) id<TOSimpleTableViewDelegate> delegate;

+ (TOSimpleTableView*) wrapTableView:(UITableView*)tableView dataSource:(NSMutableArray*)dataSource
                            delegate:(id<TOSimpleTableViewDelegate>)delegate;

@end