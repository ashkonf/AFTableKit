//
//  AFAdaptedTableViewDatasource.h
//  AFTableKit
//
//  Created by Ashkon Farhangi on 1/7/14.
//  Copyright (c) 2014 Ashkon Farhangi. All rights reserved.
//

@class AFTableRowAdapter;

@protocol AFAdaptedTableViewDatasource <NSObject>

@required

/// possible that don't need table view as argument to any of these (additional benefit of doing that would be making names of first two methods different that UITVCDatasource method names)
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (id)objectForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath; // Subclass must manage mapping of objects to index paths
/**
 * This method used to have index path argument.
 * However, giving it one is inherently problematic. This is supposed to return
 * a single adapter that will be used for that tvc's lifetime. Over that lifetime,
 * the object could appear at many different index paths. So there is no connection
 * between an adapter and index path. It's different for delegate methods, cause
 * they are really about events, which occur at single points in time at which
 * an object really only has a single index path.
 */
- (AFTableRowAdapter *)adapterForObject:(id)object inTableView:(UITableView *)tableView;

@end
