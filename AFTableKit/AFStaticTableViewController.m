//
//  AFStaticTableViewController.m
//  AFTableKit
//
//  Created by Ashkon Farhangi on 1/16/14.
//  Copyright (c) 2014 Ashkon Farhangi. All rights reserved.
//

#import "AFStaticTableViewController.h"

#import "AFStaticTableViewSection.h"
#import "AFTableCellController.h"

/**
 * Objects are cell controllers themselves.
 */
@interface AFStaticTableViewController ()

@property (nonatomic) NSMutableArray *sections;

@end

@implementation AFStaticTableViewController

- (void)addSectionWithHeader:(NSString *)header footer:(NSString *)footer
{
    [self.sections addObject:[AFStaticTableViewSection sectionWithHeader:header footer:footer]];
}

- (void)addCellWithController:(AFTableCellController *)controller
{
    AFStaticTableViewSection *section = [self.sections lastObject];
    [section addCellWithController:controller];
}

#pragma mark - AFTableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    AFStaticTableViewSection *sectionObject = self.sections[section];
    return [sectionObject.controllers count];
}

- (id)objectForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    AFStaticTableViewSection *section = self.sections[indexPath.section];
    return section.controllers[indexPath.row];
}

- (AFTableCellController *)cellControllerForObject:(id)object inTableView:(UITableView *)tableView
{
    return object;
}

#pragma mark - Setters and Getters

- (NSMutableArray *)sections
{
    if (!_sections) {
        _sections = [[NSMutableArray alloc] init];
    }
    return _sections;
}

@end
