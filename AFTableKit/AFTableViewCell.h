//
//  AFTableViewCell.h
//  AFTableKit
//
//  Created by Ashkon Farhangi on 1/8/14.
//  Copyright (c) 2014 Ashkon Farhangi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol AFTableViewCellDatasource;
@protocol AFTableViewCellDelegate;

@interface AFTableViewCell : UITableViewCell

// Returning a negative number will result in the parent table view's default row height being used
+ (CGFloat)heightForCellWidth:(CGFloat)cellWidth withDatasource:(id<AFTableViewCellDatasource>)datasource;

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;

- (void)reloadData;

@property (nonatomic, weak) id<AFTableViewCellDatasource> datasource;
@property (nonatomic, weak) id<AFTableViewCellDelegate> delegate;

@end

/**
 * Subclasses should extend this protocol so 
 * that it provides the data they need.
 */
@protocol AFTableViewCellDatasource <NSObject>

@required

@property (nonatomic, readonly) CGFloat contentInset;

@end

@protocol AFTableViewCellDelegate <NSObject>

- (void)heightChangedForCell:(AFTableViewCell *)cell;

@end
