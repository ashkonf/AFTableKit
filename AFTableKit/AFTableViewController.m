//
//  AFTableViewController.m
//  AFTableKit
//
//  Created by Ashkon Farhangi on 9/2/13.
//  Copyright (c) 2013 Ashkon Farhangi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AFTableViewController.h"

#import "AFTableCellController.h"

@interface AFTableViewController () <AFTableCellControllerDelegate>

@property (nonatomic) NSMapTable *controllers;
@property (nonatomic) NSMapTable *indexPaths;

@end

@implementation AFTableViewController

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

- (NSMapTable *)controllers
{
    if (!_controllers) {
        _controllers = [[NSMapTable alloc] init];
    }
    return _controllers;
}

- (NSMapTable *)indexPaths
{
    if (!_indexPaths) {
        _indexPaths = [[NSMapTable alloc] init];
    }
    return _indexPaths;
}

#pragma mark - AFTableViewDatasource

/**
 * IMPORTANT: Every time this method is called, _cacheLocation must be called
 * to cache the location of the object returned. Failing to do so will result
 * in invalid mappings of objects to locations.
 */
- (id)objectForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    [NSException raise:@"Subclasses should override." format:nil];
    return nil;
}

- (AFTableCellController *)cellControllerForObject:(id)object inTableView:(UITableView *)tableView
{
    [NSException raise:@"Subclasses should override." format:nil];
    return nil;
}

#pragma mark - AFTableViewDatasource + UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [NSException raise:@"Subclasses should override." format:nil];
    return 0;
}

#pragma mark - UITableViewDatasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AFTableCellController *controller = [self _controllerForTableView:tableView atIndexPath:indexPath];
    return [controller cellInTableViewController:self];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AFTableCellController *controller = [self _controllerForTableView:tableView atIndexPath:indexPath];
    return [controller heightForCellInTableViewController:self];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    AFTableCellController *controller = [self _controllerForTableView:tableView atIndexPath:indexPath];
    [controller willDisplayInTableViewController:self];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    AFTableCellController *controller = [self _controllerForTableView:tableView atIndexPath:indexPath];
    [controller didEndDisplayingInTableViewController:self];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AFTableCellController *controller = [self _controllerForTableView:tableView atIndexPath:indexPath];
    [controller didSelectInTableViewController:self];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AFTableCellController *controller = [self _controllerForTableView:tableView atIndexPath:indexPath];
    [controller didDeselectInTableViewController:self];
}

#pragma mark - AFTableCellControllerDelegate

- (UITableViewCell *)tableCellController:(AFTableCellController *)tableCellController cellForObject:(id)object
{
    NSIndexPath *indexPathForObject = [self indexPathForObject:object inTableView:self.tableView];
    return [self.tableView cellForRowAtIndexPath:indexPathForObject];
}

- (void)tableCellController:(AFTableCellController *)tableCellController heightChangedForCellWithObject:(id)object
{
    NSIndexPath *indexPathForObject = [self indexPathForObject:object inTableView:self.tableView];
    [self.tableView reloadRowsAtIndexPaths:@[indexPathForObject] withRowAnimation:UITableViewRowAnimationAutomatic]; /// different animation?
}

#pragma mark - Helper Methods

- (AFTableCellController *)_controllerForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    AFTableCellController *controller = nil;

    if (indexPath.section < [self numberOfSectionsInTableView:tableView] && indexPath.row < [self tableView:tableView numberOfRowsInSection:indexPath.section]) {
        id object = [self objectForTableView:tableView atIndexPath:indexPath];

        // Every time we ask for an object, we cache its location
        if (object) {
            [self _cacheLocation:indexPath forObject:object];
        }

        controller = [self.controllers objectForKey:object];
        if (!controller) {
            controller = [self cellControllerForObject:object inTableView:tableView];
            controller.delegate = self;
            if (controller) {
                [self.controllers setObject:controller forKey:object];
            }
        }
    }

    return controller;
}

- (void)_cacheLocation:(NSIndexPath *)location forObject:(id)object
{
    if (object) {
        [self.indexPaths setObject:location forKey:object];
    }
}

@end
