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
    UIView *clipView;
    UIView *inlineView;
}

@end


@implementation PLFormInlineViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self)
    {
        clipView = [UIView new];
        clipView.clipsToBounds = YES;
        [self.contentView addSubview:clipView];
        [clipView autoPinEdgesToSuperviewEdges];
    }
    return self;
    
}


- (void)updateWithModel:(id)model
{
    if ([model isKindOfClass:[UIView class]])
    {
        inlineView = (UIView*)model;
        [clipView addSubview:inlineView];
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
