//
//  AFTableCellController.m
//  AFTableKit
//
//  Created by Ashkon Farhangi on 9/1/13.
//  Copyright (c) 2013 Ashkon Farhangi. All rights reserved.
//

#import "AFTableCellController.h"

#import "AFTableViewController.h"
#import "UITableViewCell+AFUtilities.h"
#import "AFTableViewCell.h"

@interface AFTableCellController()

@property (nonatomic, readwrite) id object;
@property (nonatomic, weak, readwrite) AFTableViewController *tableViewController;

@property (nonatomic, readonly) UIEdgeInsets cellContentEdgeInsets;

@end

@implementation AFTableCellController

- (instancetype)initWithObject:(id)object inTableViewController:(AFTableViewController *)tableViewController
{
    self = [super init];
    if (self) {
        self.object = object;
        self.tableViewController = tableViewController;
    }
    return self;
}

/// this dependency on cell being aftableviewcell is annoying
/// would be nice for entire adapted table view scheme to work with regular table views and cells
- (void)makeCellReloadData
{
    UITableViewCell *cell = [self.delegate tableCellController:self cellForObject:self.object];
    if ([cell isKindOfClass:[AFTableViewCell class]]) {
        AFTableViewCell *afCell = (AFTableViewCell *)cell;
        [afCell reloadData];
        // Height didn't necessarily change, but we reload the cell anyway
        [self.delegate tableCellController:self cellForObject:self.object];
    }
}

#pragma mark - Datasource, so to speak

+ (Class)cellClass
{
    return [UITableViewCell class];
}

- (UITableViewCell *)cellInTableViewController:(AFTableViewController *)tableViewController
{
    UITableViewCell *cell = nil;

    Class cellClass = [[self class] cellClass];
    if ([cellClass isSubclassOfClass:[UITableViewCell class]]) {
        cell = [cellClass af_cellForTableView:tableViewController.tableView];
        if ([cell isKindOfClass:[AFTableViewCell class]]) {
            AFTableViewCell *afcell = (AFTableViewCell *)cell;
            afcell.delegate = self;
            afcell.datasource = self;
            [afcell reloadData];
        }
    }

    return cell;
}

- (CGFloat)heightForCellInTableViewController:(AFTableViewController *)tableViewController
{
    CGFloat height = self.tableViewController.tableView.rowHeight;

    Class cellClass = [[self class] cellClass];
    if ([cellClass isSubclassOfClass:[AFTableViewCell class]]) {
        height = [cellClass heightForCellWidth:(tableViewController.tableView.frame.size.width - 2 * self.cellContentInset) withDatasource:self];
    }

    return height;
}

#pragma mark - Delegate, so to speak

- (void)willDisplayInTableViewController:(AFTableViewController *)tableViewController
{
}

- (void)didEndDisplayingInTableViewController:(AFTableViewController *)tableViewController
{
}

- (void)didSelectInTableViewController:(AFTableViewController *)tableViewController
{
}

- (void)didDeselectInTableViewController:(AFTableViewController *)tableViewController
{
}

#pragma mark - Setters and Getters

/**
 * Not a lazy instantiator - notice the _object ivar is never set.
 * This method returns self if no object becuase controllers with
 * no objects are considered to have themselves as their objects.
 * The reason we don't set self to _object in such a case is that
 * a retain cycle would occur.
 *
 * One might want the controller itself to be identified as an 
 * object if multiple cells representing the same object occur within
 * a table view, which otherwise would result in a 1:many mapping
 * instead of the necessary 1:1 mapping between cells/index paths
 * and objects.
 */
- (id)object
{
    if (!_object) {
        return self;
    }
    return _object;
}

- (void)setCellContentInset:(CGFloat)cellContentInset
{
    if (cellContentInset != _cellContentInset) {
        _cellContentInset = cellContentInset;

        // To make the table view redraw the cell
        [self.tableViewController.tableView reloadData];
    }
}

#pragma mark - AFTableViewCellDatasource

/**
 * The getter for the contentInset property defined
 * in the datasource protocol.
 */
- (CGFloat)contentInset
{
    return self.cellContentInset;
}

#pragma mark - AFTableViewCellDelegate

- (void)heightChangedForCell:(AFTableViewCell *)cell
{
    [self.delegate tableCellController:self heightChangedForCellWithObject:self.object];
}

@end
