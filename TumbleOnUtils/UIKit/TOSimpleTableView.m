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

#import "TOSimpleTableView.h"

@implementation TOSimpleTableView

+ (TOSimpleTableView*) wrapTableView:(UITableView*)tableView dataSource:(NSMutableArray*)dataSource
                            delegate:(id<TOSimpleTableViewDelegate>)delegate {
    TOSimpleTableView * stv = [[TOSimpleTableView alloc] init];
    stv.tableView = tableView;
    stv.allowEdits = YES;
    stv.dataSource = dataSource;
    stv.delegate = delegate;
    tableView.delegate = stv;
    tableView.dataSource = stv;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:stv.defaultCellIdentifier];
    return stv;
}

- (NSString *)defaultCellIdentifier { return @"TOSimpleTableView-Cell"; }
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { return 1; }
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { return [self.dataSource count]; }
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath { return self.allowEdits; }

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        NSObject * object = [self.dataSource objectAtIndex:indexPath.row];
		[self.dataSource removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        if ([self.delegate respondsToSelector:@selector(toSimpleTableView:objectDeleted:index:)]) {
            [self.delegate toSimpleTableView:self objectDeleted:object index:indexPath.row];
        }
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        NSLog(@"ERROR: TOSimpleTableView doesnt support UITableViewCellEditingStyleInsert");
    }   
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath  {
    NSObject * item = [self.dataSource objectAtIndex:fromIndexPath.row];
    [self.dataSource removeObjectAtIndex:fromIndexPath.row];
    [self.dataSource insertObject:item atIndex:toIndexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (![self.delegate respondsToSelector:@selector(toSimpleTableView:objectSelected:index:cell:)]) {
        return;
    }
    NSObject * object = [self.dataSource objectAtIndex:indexPath.row];
    UITableViewCell * cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [self.delegate toSimpleTableView:self objectSelected:object index:indexPath.row cell:cell];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSObject * object = [self.dataSource objectAtIndex:indexPath.row];
    if (![self.delegate respondsToSelector:@selector(toSimpleTableView:createCellForObject:index:)]) {
        UITableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:self.defaultCellIdentifier];
        cell.textLabel.text = [object description];
        return cell;
    }
    return [self.delegate toSimpleTableView:self createCellForObject:object index:indexPath.row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self tableView:tableView cellForRowAtIndexPath:indexPath].frame.size.height;
}

@end
