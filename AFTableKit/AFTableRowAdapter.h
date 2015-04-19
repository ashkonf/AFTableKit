//
//  AFTableCellAdapter.h
//  AFTableKit
//
//  Created by Ashkon Farhangi on 9/1/13.
//  Copyright (c) 2013 Ashkon Farhangi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AFTableViewCell.h"

@class AFAdaptedTableViewController;

@protocol AFTableRowAdapterDelegate;

@interface AFTableRowAdapter : NSObject <AFTableViewCellDatasource, AFTableViewCellDelegate>

- (instancetype)initWithObject:(id)object inTableViewController:(AFAdaptedTableViewController *)tableViewController;

- (void)makeCellReloadData;

@property (nonatomic, readonly) id object; // A nil object means the adapter itself should be treated as the object
@property (nonatomic, weak, readonly) AFAdaptedTableViewController *tableViewController; /// any way to avoid making this a property?
@property (nonatomic, weak) id<AFTableRowAdapterDelegate> delegate; /// it's really weird that have both TVC property and delegate, that end up pointing to the same thing
/// only reason have that tvc property, I think, is to allow adapters to push VCs
/// maybe can just make delegate method that takes in VC and pushes it
/// CAN MAKE A DELEGATE METHOD THAT RETURNS A VC THAT IS THE VC CAN PUSH FROM

/// maybe make this uiedgeinsets, so can customize insets in all directions
/// mainly useful in doing different horizontal vs vertical I think
/// a prob with content inset right now is that for top and bottom cells, vertical padding is fucked up cause no cell vertically next to so spacing doubles
@property (nonatomic) CGFloat cellContentInset;

// Data source, so to speak
+ (Class)cellClass;
- (UITableViewCell *)cellInTableViewController:(AFAdaptedTableViewController *)tableViewController;
- (CGFloat)heightForCellInTableViewController:(AFAdaptedTableViewController *)tableViewController; //// this probably has to change

// Delegate, so to speak
/// basing method names sorta off of UITableViewDelegate methods (really just inspired by)
/// add in cell arguments? if sticking with delegate thing where can just ask for argument, no need. good thing about delegate is that allows access to cell outside of table view events (like events relevant to shit having loaded)
/// don't like that have object in name when object is no arg, and that arg name is not right before arg
- (void)willDisplayInTableViewController:(AFAdaptedTableViewController *)tableViewController;
- (void)didEndDisplayingInTableViewController:(AFAdaptedTableViewController *)tableViewController;
- (void)didSelectInTableViewController:(AFAdaptedTableViewController *)tableViewController;
- (void)didDeselectInTableViewController:(AFAdaptedTableViewController *)tableViewController;

@end

/// best way to give adapter access to cell?
@protocol AFTableRowAdapterDelegate <NSObject>

/// pass in adapter as argument with these too?

@required

- (UITableViewCell *)tableRowAdapter:(AFTableRowAdapter *)tableRowAdapter cellForObject:(id)object;

@optional

/// pass height along with this? any reason would make things more efficient?
- (void)tableRowAdapter:(AFTableRowAdapter *)tableRowAdapter heightChangedForCellWithObject:(id)object;

@end
