//
//  AFTextFieldCell.m
//  AFTableKit
//
//  Created by Ashkon Farhangi on 9/1/13.
//  Copyright (c) 2014 Ashkon Farhangi. All rights reserved.
//

#import "AFTextFieldCell.h"

#import "UIKitConstants+AFEstimates.h"

@implementation AFTextFieldCell

@synthesize textField = _textField;

#pragma mark - AFTableViewCell

- (CGFloat)heightInTableView:(UITableView *)tableView
{
    return [self _lineHeight] + 2 * DEFAULT_TABLE_CELL_CONTENT_INSET;
}

#pragma mark - UITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.textField];
    }
    return self;
}

#pragma mark - Layout

- (CGRect)_textFieldFrame
{
    CGFloat lineHeight = [self _lineHeight];
    CGFloat verticalMargin = (self.bounds.size.height - lineHeight) / 2;
    CGFloat xCoord = DEFAULT_TABLE_CELL_CONTENT_INSET;
    CGFloat yCoord = verticalMargin;
    CGFloat width = self.contentView.frame.size.width - xCoord - DEFAULT_TABLE_CELL_CONTENT_INSET;
    CGFloat height = self.bounds.size.height - yCoord - verticalMargin;
    return CGRectMake(xCoord, yCoord, width, height);
}

#pragma mark - UIView

- (void)layoutSubviews
{
    [super layoutSubviews];

    self.textField.frame = [self _textFieldFrame];
}

#pragma mark - Getters and Setters

- (UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.backgroundColor = [UIColor clearColor];
    }
    return _textField;
}

#pragma mark - Helper Methods

- (CGFloat)_lineHeight
{
    NSDictionary *attributes = @{ NSFontAttributeName : self.textField.font };
    return [@"TGgasdf1j$" sizeWithAttributes:attributes].height;
}

@end
