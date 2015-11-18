//
//  PLFloatingSelectCell.m
//  Pitch
//
//  Created by Ashley Thwaites on 05/01/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//

#import "PLFloatingSelectCell.h"
#import "PureLayout.h"

@interface PLFloatingSelectCell ()

@property (nonatomic, readwrite) PLFloatingLabelSelectField *selectField;

@end


@implementation PLFloatingSelectCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self)
    {
        _selectField = [[PLFloatingLabelSelectField alloc] initWithFrame:self.bounds];
        [self addSubview:_selectField];
        [_selectField autoPinEdgesToSuperviewEdges];
    }
    return self;
    
}

- (void)updateWithModel:(id)model
{
    if ([model isKindOfClass:[PLFormSelectFieldElement class]])
    {
        [self.selectField updateWithElement:model];
    }
}

@end
