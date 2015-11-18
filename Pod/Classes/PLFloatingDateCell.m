//
//  PLFloatingDateCell.m
//  Pitch
//
//  Created by Ashley Thwaites on 05/01/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//


#import "PLFloatingDateCell.h"
#import "PureLayout.h"

@interface PLFloatingDateCell ()

@property (nonatomic, readwrite) PLFloatingLabelDateField *dateField;

@end


@implementation PLFloatingDateCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self)
    {
        _dateField = [[PLFloatingLabelDateField alloc] initWithFrame:self.bounds];
        [self addSubview:_dateField];
        [_dateField autoPinEdgesToSuperviewEdges];
    }
    return self;
    
}

- (void)updateWithModel:(id)model
{
    if ([model isKindOfClass:[PLFormDateFieldElement class]])
    {
        [self.dateField updateWithElement:model];
    }
}

@end
