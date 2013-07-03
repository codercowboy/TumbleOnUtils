/*
 
 TableViewHelper.m
 
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
 
 Created by Jason Baker (jason@onejasonforsale.com)
 & Adam Zacharski (zacharski@gmail.com) for TumbleOn, March 2012.
 
 The latest version of this code is available here:
 
 - https://bitbucket.org/tumbleon/tumbleon-utils
 
 This code is licensed under the Apache license, a non-viral open source license
 that lets you use this code freely within your own projects without requiring
 your project itself to also be open source. More information about the Apache
 license is here:
 
 - http://en.wikipedia.org/wiki/Apache_license
 
 Copyright (c) 2012, Pocket Sized Giraffe, LLC. All rights reserved.
 
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

#import "TableViewHelper.h"

@implementation TableViewHelper

@synthesize myTableView, dataSource, allowEdits, delegate;

+ (TableViewHelper *) createTableViewHelper:(UITableView *)tableView dataSource:(NSMutableArray *)dataSource delegate:(id)delegate {
    TableViewHelper * tvh = [[TableViewHelper alloc] init];
    tvh.myTableView = tableView;
    tvh.allowEdits = YES;
    tvh.dataSource = dataSource;
    tvh.delegate = delegate;
    tableView.delegate = tvh;
    tableView.dataSource = tvh;
    return tvh;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource count];
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return self.allowEdits;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        NSObject * object = [self.dataSource objectAtIndex:indexPath.row];
		[self.dataSource removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        if ([self.delegate respondsToSelector:@selector(objectDeleted:)]) {
            [self.delegate objectDeleted:object];
        }
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        NSLog(@"ERROR: TableViewHelper doesnt support UITableViewCellEditingStyleInsert");
    }   
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath  {
    NSObject * item = [self.dataSource objectAtIndex:fromIndexPath.row];
    [self.dataSource removeObjectAtIndex:fromIndexPath.row];
    [self.dataSource insertObject:item atIndex:toIndexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSObject * object = [self.dataSource objectAtIndex:indexPath.row];
    UITableViewCell * cell = [self.myTableView cellForRowAtIndexPath:indexPath];
    [self.delegate objectSelected:object cell:cell];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSObject * object = [self.dataSource objectAtIndex:indexPath.row];
    return [delegate createCellForObject:object];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];    return cell.frame.size.height;    
}

- (void) reload {
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    [self.myTableView reloadData];
}

@end
