//
//  UITableViewCell+AFUtilities.h
//  AFTableKit
//
//  Created by Ashkon Farhangi on 8/7/13.
//  Copyright (c) 2013 Ashkon Farhangi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UITableViewCell (AFUtilities)

+ (instancetype)af_cellForTableView:(UITableView *)tableView withStyle:(UITableViewCellStyle)style;
+ (instancetype)af_cellForTableView:(UITableView *)tableView;
+ (instancetype)af_staticCellWithStyle:(UITableViewCellStyle)style;
+ (instancetype)af_staticCell;

@end
