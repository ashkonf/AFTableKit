//
//  AFAdaptedTableViewController.m
//  AFTableKit
//
//  Created by Ashkon Farhangi on 9/2/13.
//  Copyright (c) 2013 Ashkon Farhangi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AFAdaptedTableViewController.h"

#import "AFTableRowAdapter.h"

/// in general, would be nice to restrict access to data as much as possible
/// don't hold on to properties if can limit data access to inside methods where that data can be passed in
/// releant often for delegate methods

@interface AFAdaptedTableViewController () <AFTableRowAdapterDelegate>

@property (nonatomic) NSMapTable *adapters;
@property (nonatomic) NSMapTable *indexPaths;

@end

@implementation AFAdaptedTableViewController

- (NSIndexPath *)indexPathForObject:(id)object inTableView:(UITableView *)tableView
{
    NSIndexPath *indexPath = [self.indexPaths objectForKey:object];
    if (indexPath.section < [self numberOfSectionsInTableView:self.tableView]) {
        if (indexPath.row < [self tableView:self.tableView numberOfRowsInSection:indexPath.section]) {
            if ([self objectForTableView:self.tableView atIndexPath:indexPath] == object) {
                // The index path in the cache was valid
                return indexPath;
            }
        }
    }

    // The index path in the cache was invalid

    indexPath = nil;
    [self.indexPaths removeObjectForKey:object];

    return nil;
}

#pragma mark - Setters and Getters

- (NSMapTable *)adapters
{
    if (!_adapters) {
        _adapters = [[NSMapTable alloc] init];
    }
    return _adapters;
}

- (NSMapTable *)indexPaths
{
    if (!_indexPaths) {
        _indexPaths = [[NSMapTable alloc] init];
    }
    return _indexPaths;
}

#pragma mark - AFAdaptedTableViewDatasource

/**
 * IMPORTANT: Every time this method is called, _cacheLocation must be called
 * to cache the location of the object returned. Failing to do so will result
 * in invalid mappings of objects to locations.
 */
- (id)objectForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (AFTableRowAdapter *)adapterForObject:(id)object inTableView:(UITableView *)tableView
{
    /// maybe make default case here where recognizes adapters automatccally and returns them
    /// ie in each layer (sbuclass) checks to see if super returns nil, and if so then does own shit
    /// could override super class for some classes by doing some shit before calling super, then calling super, and then doing other stuff
    return nil;
}

#pragma mark - AFAdaptedTableViewDatasource + UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

#pragma mark - UITableViewDatasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AFTableRowAdapter *adapter = [self _adapterForTableView:tableView atIndexPath:indexPath];
    return [adapter cellInTableViewController:self];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AFTableRowAdapter *adapter = [self _adapterForTableView:tableView atIndexPath:indexPath];
    return [adapter heightForCellInTableViewController:self];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    AFTableRowAdapter *adapter = [self _adapterForTableView:tableView atIndexPath:indexPath];
    [adapter willDisplayInTableViewController:self];
}

/// seems like adapter will always be nil, cause object for this index path will no longer exist
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    AFTableRowAdapter *adapter = [self _adapterForTableView:tableView atIndexPath:indexPath];
    [adapter didEndDisplayingInTableViewController:self];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AFTableRowAdapter *adapter = [self _adapterForTableView:tableView atIndexPath:indexPath];
    [adapter didSelectInTableViewController:self];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AFTableRowAdapter *adapter = [self _adapterForTableView:tableView atIndexPath:indexPath];
    [adapter didDeselectInTableViewController:self];
}

#pragma mark - AFTableRowAdapterDelegate

- (UITableViewCell *)tableRowAdapter:(AFTableRowAdapter *)tableRowAdapter cellForObject:(id)object
{
    NSIndexPath *indexPathForObject = [self indexPathForObject:object inTableView:self.tableView];
    return [self.tableView cellForRowAtIndexPath:indexPathForObject];
}

- (void)tableRowAdapter:(AFTableRowAdapter *)tableRowAdapter heightChangedForCellWithObject:(id)object
{
    NSIndexPath *indexPathForObject = [self indexPathForObject:object inTableView:self.tableView];
    [self.tableView reloadRowsAtIndexPaths:@[indexPathForObject] withRowAnimation:UITableViewRowAnimationAutomatic]; /// different animation?
}

#pragma mark - Helper Methods

- (AFTableRowAdapter *)_adapterForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    AFTableRowAdapter *adapter = nil;

    if (indexPath.section < [self numberOfSectionsInTableView:tableView] && indexPath.row < [self tableView:tableView numberOfRowsInSection:indexPath.section]) {
        id object = [self objectForTableView:tableView atIndexPath:indexPath];

        // Every time we ask for an object, we cache its location
        if (object) {
            [self _cacheLocation:indexPath forObject:object];
        }

        adapter = [self.adapters objectForKey:object];
        if (!adapter) {
            adapter = [self adapterForObject:object inTableView:tableView];
            adapter.delegate = self;
            if (adapter) {
                [self.adapters setObject:adapter forKey:object];
            }
        }
    }

    return adapter;
}

- (void)_cacheLocation:(NSIndexPath *)location forObject:(id)object
{
    if (object) {
        [self.indexPaths setObject:location forKey:object];
    }
}

@end
