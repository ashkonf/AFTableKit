//
//  AFTableViewDatasource.h
//  AFTableKit
//
//  Created by Ashkon Farhangi on 1/7/14.
//  Copyright (c) 2014 Ashkon Farhangi. All rights reserved.
//

@class AFTableCellController;

@protocol AFTableViewDatasource <NSObject>

@required

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (id)objectForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath; // Subclass must manage mapping of objects to index paths
- (AFTableCellController *)cellControllerForObject:(id)object inTableView:(UITableView *)tableView;

@end
