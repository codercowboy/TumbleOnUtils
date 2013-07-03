/*
 
 TOSimpleTableViewExample
 
 An example implementation demonstrating the benefits of TableViewHelper.
 
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

#import "TOSimpleTableViewExample.h"

@interface TOSimpleTableViewExample ()

@end

@implementation TOSimpleTableViewExample

@synthesize tableView, toSimpleTableView, dataSource;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    //first, we create our data source
    self.dataSource = [NSMutableArray array];
    [self.dataSource addObject:@"Adam"];
    [self.dataSource addObject:@"Amanda"];
    [self.dataSource addObject:@"Jason"];
    
    //next, create the tableview..
    self.tableView = [[UITableView alloc] initWithFrame:
                      CGRectMake(0,0,self.view.frame.size.width,
                                 self.view.frame.size.height)];
    [self.view addSubview:self.tableView];
    
    //now setup our tableviewhelper
    self.toSimpleTableView = [TOSimpleTableView createTableViewHelper:self.tableView
                                                       dataSource:self.dataSource
                                                         delegate:self];
    
    //by default, tableviewhelper allows edits, to turn that off we do this:
    self.toSimpleTableView.allowEdits = NO;
    
    //if the tableviewhelper allows edits, moving items in the list will be automatically
    // handled by the tableviewhelper, as will deletes
    
    //when a delete happens, our delegate method objectDeleted will be called, in case
    // we want to save state or something..
    
    //note that tableviewhelper is intended for very simple use cases, and thus hard codes
    // the section count for this table to 1.
}

- (void) addAction {
    //if we wanted to add an object to our data source and reload the table
    // we'd simply do this..
    [self.dataSource addObject:@"TumbleOn"];
    [self.tableView reloadData];
}

- (void) startEditAction {
    //to enable edits we'd do this.. and that's it, no UITableViewDelegate methods to worry
    // about b/c tableviewhelper automatically handles that for us
    [self.tableView setEditing:YES animated:YES];
}

- (void) endEditAction {
    //disabling edits..
    // now would be a good time to save state
    [self.tableView setEditing:NO animated:YES];
}

/* Create and return a UITableViewCell instance for the given object from your data source. */
- (UITableViewCell *) createCellForObject:(NSObject *)object {
    // this is essentially UITableViewDelegate's cellForRowAtIndexPath impl
    NSLog(@"Creating cell for object: %@", (NSString*)object);
    NSString * cellIdentifier = @"someIdentifier";
    UITableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = (NSString*)object;
    return cell;
}

/* Perform an action based on the given selected object from your data source. */
/* Provided cell object is the cell you've wrapped around the object. */
- (void) objectSelected:(NSObject *)object cell:(UITableViewCell *)cell {
    NSLog(@"Object selected: %@", (NSString*)object);
}

/* Optional method to perform an action when the given item is removed from your data source */
- (void) objectDeleted:(NSObject *)object {
    NSLog(@"Object deleted: %@", (NSString*)object);
}


@end
