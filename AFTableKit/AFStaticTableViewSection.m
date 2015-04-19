//
//  AFStaticTableViewSection.m
//  AFTableKit
//
//  Created by Ashkon Farhangi on 1/16/14.
//  Copyright (c) 2014 Ashkon Farhangi. All rights reserved.
//

#import "AFStaticTableViewSection.h"

@implementation AFStaticTableViewSection

@synthesize adapters = _adapters;

+ (AFStaticTableViewSection *)sectionWithHeader:(NSString *)header footer:(NSString *)footer
{
    AFStaticTableViewSection *section = [[AFStaticTableViewSection alloc] init];
    section.header = header;
    section.footer = footer;
    return section;
}

- (void)addCellWithAdapter:(AFTableRowAdapter *)adapter
{
    [self.adapters addObject:adapter];
}

#pragma mark - Setters and Getters

- (NSMutableArray *)adapters
{
    if (!_adapters) {
        _adapters = [[NSMutableArray alloc] init];
    }
    return _adapters;
}

@end
