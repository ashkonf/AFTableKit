//
//  AFImageCell.m
//  AFTableKit
//
//  Created by Ashkon Farhangi on 1/7/14.
//  Copyright (c) 2014 Ashkon Farhangi. All rights reserved.
//

#import "AFImageCell.h"

@interface AFImageCell()

@end

@implementation AFImageCell

#pragma mark - AFTableViewCell

- (CGFloat)heightInTableView:(UITableView *)tableView
{
    CGFloat height = 0;

    if (self.image) {
        height = self.contentView.frame.size.width / self.image.size.width * self.image.size.height;
    }

    return height;
}

#pragma mark - UITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

#pragma mark - UIView

- (void)layoutSubviews
{
    [super layoutSubviews];

    self.imageView.frame = [self _imageViewFrame];
}

#pragma mark - Layout

- (CGRect)_imageViewFrame
{
    return self.contentView.bounds;
}

#pragma mark - Getters and Setters

- (void)setImage:(UIImage *)image
{
    self.imageView.image = image;
}

- (UIImage *)image
{
    return self.imageView.image;
}

@end
