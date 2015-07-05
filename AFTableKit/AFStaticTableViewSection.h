//
//  AFStaticTableViewSection.h
//  AFTableKit
//
//  Created by Ashkon Farhangi on 1/16/14.
//  Copyright (c) 2014 Ashkon Farhangi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class AFTableCellController;

@interface AFStaticTableViewSection : NSObject

+ (AFStaticTableViewSection *)sectionWithHeader:(NSString *)header footer:(NSString *)footer;

@property (nonatomic, readonly) NSMutableArray *controllers;
@property (nonatomic) NSString *header;
@property (nonatomic) NSString *footer;

- (void)addCellWithController:(AFTableCellController *)controller;

@end
