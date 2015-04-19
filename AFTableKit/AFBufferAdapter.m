//
//  AFBufferAdapter.m
//  AFTableKit
//
//  Created by Ashkon Farhangi on 1/31/14.
//  Copyright (c) 2014 Ashkon Farhangi. All rights reserved.
//

#import "AFBufferAdapter.h"

#import "AFAdaptedTableViewController.h"
#import "UITableViewCell+AFUtilities.h"

@implementation AFBufferAdapter

#pragma mark - AFTableRowAdapter

- (instancetype)initWithObject:(id)object inTableViewController:(AFAdaptedTableViewController *)tableViewController
{
    self = [super initWithObject:object inTableViewController:tableViewController];
    if (self) {
        // Initialization
    }
    return self;
}

- (UITableViewCell *)cellInTableViewController:(AFAdaptedTableViewController *)tableViewController
{
    return [UITableViewCell af_cellForTableView:tableViewController.tableView];
}

- (CGFloat)heightForCellInTableViewController:(AFAdaptedTableViewController *)tableViewController
{
    return self.height;
}
@end
