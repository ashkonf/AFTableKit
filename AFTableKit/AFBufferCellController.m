//
//  AFBufferCellController.m
//  AFTableKit
//
//  Created by Ashkon Farhangi on 1/31/14.
//  Copyright (c) 2014 Ashkon Farhangi. All rights reserved.
//

#import "AFBufferCellController.h"

#import "AFTableViewController.h"
#import "UITableViewCell+AFUtilities.h"

@implementation AFBufferCellController

#pragma mark - AFTableCellController

- (instancetype)initWithObject:(id)object inTableViewController:(AFTableViewController *)tableViewController
{
    self = [super initWithObject:object inTableViewController:tableViewController];
    if (self) {
        // Initialization
    }
    return self;
}

- (UITableViewCell *)cellInTableViewController:(AFTableViewController *)tableViewController
{
    return [UITableViewCell af_cellForTableView:tableViewController.tableView];
}

- (CGFloat)heightForCellInTableViewController:(AFTableViewController *)tableViewController
{
    return self.height;
}
@end
