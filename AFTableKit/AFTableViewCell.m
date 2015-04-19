//
//  AFTableViewCell.m
//  AFTableKit
//
//  Created by Ashkon Farhangi on 1/8/14.
//  Copyright (c) 2014 Ashkon Farhangi. All rights reserved.
//

#define HEIGHT_DIFFERENCE_MARGIN_OF_ERROR 0.5

#import "AFTableViewCell.h"

@implementation AFTableViewCell

+ (CGFloat)heightForCellWidth:(CGFloat)cellWidth withDatasource:(id<AFTableViewCellDatasource>)datasource
{
    return -1;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    return [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
}

- (void)reloadData
{
    // Subclasses should override
}

#pragma mark - UITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

#pragma mark - UIView

/// need this at all?
/// does this break MVC in any way?
- (void)layoutSubviews
{
    [super layoutSubviews];

    // We divide the inset by 2 in the vertical case because the insets for vertically consecutive cells will compound
    self.contentView.frame = CGRectInset(self.bounds, self.datasource.contentInset, self.datasource.contentInset / 2);

    CGFloat desiredHeight = [[self class] heightForCellWidth:self.contentView.frame.size.width withDatasource:self.datasource];
    if (fabs(desiredHeight - self.frame.size.height) >= HEIGHT_DIFFERENCE_MARGIN_OF_ERROR) {
        /// this crashes because aftableviewcells are used outside adapted table views
        [self.delegate heightChangedForCell:self];
    }
}

@end
