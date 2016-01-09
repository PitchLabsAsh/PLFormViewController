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
        [self.contentView addSubview:_dateField];
        [_dateField autoPinEdgesToSuperviewEdges];
        _dateField.userInteractionEnabled = NO;
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

- (BOOL)canBecomeFirstResponder
{
    return [_dateField canBecomeFirstResponder];
}

- (BOOL)becomeFirstResponder;
{
    return [_dateField becomeFirstResponder];
}

- (BOOL)canResignFirstResponder;
{
    return [_dateField canResignFirstResponder];
}

- (BOOL)resignFirstResponder;
{
    return [_dateField resignFirstResponder];
}

- (BOOL)isFirstResponder;
{
    return [_dateField isFirstResponder];
}

@end
