//
//  PLFormInlinePickerCell.m
//  Pitch
//
//  Created by Ashley Thwaites on 05/01/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//


#import "PLFormInlineViewCell.h"
#import "PureLayout.h"

@interface PLFormInlineViewCell ()
{
    UIView *inlineView;
}

@end


@implementation PLFormInlineViewCell

- (void)updateWithModel:(id)model
{
    if ([model isKindOfClass:[UIView class]])
    {
        inlineView = (UIView*)model;
        [self.contentView addSubview:inlineView];
        [inlineView autoPinEdgesToSuperviewEdges];
    }
}

- (void)prepareForReuse
{
    [inlineView removeFromSuperview];
    [super prepareForReuse];
}

-(id)model
{
    return inlineView;
}

@end
