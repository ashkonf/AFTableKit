//
//  AFTableCellController.h
//  AFTableKit
//
//  Created by Ashkon Farhangi on 9/1/13.
//  Copyright (c) 2013 Ashkon Farhangi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AFTableViewCell.h"

@class AFTableViewController;

@protocol AFTableCellControllerDelegate;

@interface AFTableCellController : NSObject <AFTableViewCellDatasource, AFTableViewCellDelegate>

- (instancetype)initWithObject:(id)object inTableViewController:(AFTableViewController *)tableViewController;

- (void)makeCellReloadData;

@property (nonatomic, readonly) id object; // A nil object means the controller itself should be treated as the object
@property (nonatomic, weak, readonly) AFTableViewController *tableViewController; /// any way to avoid making this a property?
@property (nonatomic, weak) id<AFTableCellControllerDelegate> delegate; /// it's really weird that have both TVC property and delegate, that end up pointing to the same thing
/// only reason have that tvc property, I think, is to allow cell controllers to push VCs
/// maybe can just make delegate method that takes in VC and pushes it
/// CAN MAKE A DELEGATE METHOD THAT RETURNS A VC THAT IS THE VC CAN PUSH FROM

/// maybe make this uiedgeinsets, so can customize insets in all directions
/// mainly useful in doing different horizontal vs vertical I think
/// a prob with content inset right now is that for top and bottom cells, vertical padding is fucked up cause no cell vertically next to so spacing doubles
@property (nonatomic) CGFloat cellContentInset;

// Data source, so to speak
+ (Class)cellClass;
- (UITableViewCell *)cellInTableViewController:(AFTableViewController *)tableViewController;
- (CGFloat)heightForCellInTableViewController:(AFTableViewController *)tableViewController; //// this probably has to change

// Delegate, so to speak
/// basing method names sorta off of UITableViewDelegate methods (really just inspired by)
/// add in cell arguments? if sticking with delegate thing where can just ask for argument, no need. good thing about delegate is that allows access to cell outside of table view events (like events relevant to shit having loaded)
/// don't like that have object in name when object is no arg, and that arg name is not right before arg
- (void)willDisplayInTableViewController:(AFTableViewController *)tableViewController;
- (void)didEndDisplayingInTableViewController:(AFTableViewController *)tableViewController;
- (void)didSelectInTableViewController:(AFTableViewController *)tableViewController;
- (void)didDeselectInTableViewController:(AFTableViewController *)tableViewController;

@end

/// best way to give controller access to cell?
@protocol AFTableCellControllerDelegate <NSObject>

/// pass in controller as argument with these too?

@required

- (UITableViewCell *)tableCellController:(AFTableCellController *)tableCellController cellForObject:(id)object;

@optional

/// pass height along with this? any reason would make things more efficient?
- (void)tableCellController:(AFTableCellController *)tableCellController heightChangedForCellWithObject:(id)object;

@end
