//
//  PLSwitchCell.m
//  Pitch
//
//  Created by Ashley Thwaites on 05/01/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//


#import "PLSwitchCell.h"
#import "PureLayout.h"


@interface PLSwitchCell ()

@property (nonatomic, readwrite) PLFormSwitchField *switchField;

@end


@implementation PLSwitchCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self)
    {
        _switchField = [[PLFormSwitchField alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:_switchField];
        [_switchField autoPinEdgesToSuperviewEdges];
    }
    return self;
    
}

- (void)updateWithModel:(id)model
{
    if ([model isKindOfClass:[PLFormSwitchFieldElement class]])
    {
        [self.switchField updateWithElement:model];
    }
}

@end
