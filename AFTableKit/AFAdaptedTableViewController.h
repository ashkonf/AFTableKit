//
//  AFAdaptedTableViewController.h
//  AFTableKit
//
//  Created by Ashkon Farhangi on 9/2/13.
//  Copyright (c) 2013 Ashkon Farhangi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "AFAdaptedTableViewDatasource.h"

/// I don't think making conform to protocol forces subclasses to implement methods, because they are implemented here
/// pretty big style problem
/// someone could subclass and forget to implement a method, and then not realize why fucking up
@interface AFAdaptedTableViewController : UITableViewController <AFAdaptedTableViewDatasource>

- (NSIndexPath *)indexPathForObject:(id)object inTableView:(UITableView *)tableView;

@end
