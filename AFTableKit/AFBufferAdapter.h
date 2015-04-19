//
//  AFBufferAdapter.h
//  AFTableKit
//
//  Created by Ashkon Farhangi on 1/31/14.
//  Copyright (c) 2014 Ashkon Farhangi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AFTableRowAdapter.h"

@interface AFBufferAdapter : AFTableRowAdapter

@property (nonatomic) CGFloat height;
@property (nonatomic) UIColor *backgroundColor;
@property (nonatomic) UIColor *borderColor;
@property (nonatomic) CGFloat borderWidth;

@end
