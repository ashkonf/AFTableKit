//
//  AFStaticTableViewController.h
//  AFTableKit
//
//  Created by Ashkon Farhangi on 1/16/14.
//  Copyright (c) 2014 Ashkon Farhangi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AFAdaptedTableViewController.h"

@class AFTableRowAdapter;

@interface AFStaticTableViewController : AFAdaptedTableViewController

- (void)addSectionWithHeader:(NSString *)header footer:(NSString *)footer;
- (void)addCellWithAdapter:(AFTableRowAdapter *)adapter;

@end
