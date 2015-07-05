//
//  AFTableViewController.h
//  AFTableKit
//
//  Created by Ashkon Farhangi on 9/2/13.
//  Copyright (c) 2013 Ashkon Farhangi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "AFTableViewDatasource.h"

@interface AFTableViewController : UITableViewController <AFTableViewDatasource>

- (NSIndexPath *)indexPathForObject:(id)object inTableView:(UITableView *)tableView;

@end
