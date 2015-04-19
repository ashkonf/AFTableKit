//
//  AFTextViewCell.m
//  AFTableKit
//
//  Created by Ashkon Farhangi on 9/1/13.
//  Copyright (c) 2013 Ashkon Farhangi. All rights reserved.
//

#import "AFTextViewCell.h"

#import "UIKitConstants+AFEstimates.h"

#define ON_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define DEFAULT_HEIGHT (ON_IPAD ? 250.0 : 150.0)

@interface AFTextViewCell() <UITextViewDelegate>

@end

@implementation AFTextViewCell

@synthesize textView = _textView;

#pragma mark - AFTableViewCell

- (CGFloat)heightInTableView:(UITableView *)tableView
{
    return [self _suggestedHeight];
}

#pragma mark - UITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.textView];
    }
    return self;
}

#pragma mark - Layout

- (CGRect)_textViewFrame
{
    CGFloat xCoord = DEFAULT_TABLE_CELL_CONTENT_INSET;
    CGFloat yCoord = DEFAULT_TABLE_CELL_CONTENT_INSET;
    CGFloat width = self.bounds.size.width - xCoord - DEFAULT_TABLE_CELL_CONTENT_INSET;
    CGFloat height = self.bounds.size.height - yCoord - DEFAULT_TABLE_CELL_CONTENT_INSET;
    return CGRectMake(xCoord, yCoord, width, height);
}

#pragma mark - UIView

- (void)layoutSubviews
{
    [super layoutSubviews];

    self.textView.frame = [self _textViewFrame];
    [self _updateHeightIfNecessary];
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView
{
    [self _updateHeightIfNecessary];
}

#pragma mark - Setters and Getters

- (UITextView *)textView
{
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.backgroundColor = [UIColor clearColor];
        _textView.delegate = self;
    }
    return _textView;
}

- (void)setEditable:(BOOL)editable
{
    _editable = editable;
    [self _updateHeightIfNecessary];
}

#pragma mark - Helper Methods

- (CGFloat)_suggestedHeight
{
    CGFloat height = 0;

    if (self.isEditable) {
        height = DEFAULT_HEIGHT;
    } else {
        NSDictionary *textViewAttributes = @{ NSFontAttributeName : self.textView.font, NSParagraphStyleAttributeName : [NSParagraphStyle defaultParagraphStyle] };
        height = [self.textView.text boundingRectWithSize:CGSizeMake(self.textView.frame.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:textViewAttributes context:nil].size.height;
    }

    return height;
}

- (void)_updateHeightIfNecessary
{

}

@end
