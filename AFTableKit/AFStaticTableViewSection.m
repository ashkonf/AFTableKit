//
//  AFStaticTableViewSection.m
//  AFTableKit
//
//  Created by Ashkon Farhangi on 1/16/14.
//  Copyright (c) 2014 Ashkon Farhangi. All rights reserved.
//

#import "AFStaticTableViewSection.h"

@implementation AFStaticTableViewSection

@synthesize controllers = _controllers;

+ (AFStaticTableViewSection *)sectionWithHeader:(NSString *)header footer:(NSString *)footer
{
    AFStaticTableViewSection *section = [[AFStaticTableViewSection alloc] init];
    section.header = header;
    section.footer = footer;
    return section;
}

- (void)addCellWithController:(AFTableCellController *)controller
{
    [self.controllers addObject:controller];
}

#pragma mark - Setters and Getters

- (NSMutableArray *)controllers
{
    if (!_controllers) {
        _controllers = [[NSMutableArray alloc] init];
    }
    return _controllers;
}

@end
