//
//  AFTextViewCell.h
//  AFTableKit
//
//  Created by Ashkon Farhangi on 9/1/13.
//  Copyright (c) 2013 Ashkon Farhangi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AFTableViewCell.h"

@interface AFTextViewCell : AFTableViewCell

@property (nonatomic, readonly) UITextView *textView;
@property (nonatomic, getter = isEditable) BOOL editable;

@end
