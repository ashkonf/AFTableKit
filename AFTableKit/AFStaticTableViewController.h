//
//  AFStaticTableViewController.h
//  AFTableKit
//
//  Created by Ashkon Farhangi on 1/16/14.
//  Copyright (c) 2014 Ashkon Farhangi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AFTableViewController.h"

@class AFTableCellController;

@interface AFStaticTableViewController : AFTableViewController

- (void)addSectionWithHeader:(NSString *)header footer:(NSString *)footer;
- (void)addCellWithController:(AFTableCellController *)controller;

@end
