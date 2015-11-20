//
//  PLFloatingAutoCompleteCell.m
//  Pitch
//
//  Created by Ashley Thwaites on 05/01/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//

#import "PLFloatingAutoCompleteCell.h"
#import "PureLayout.h"

@interface PLFloatingAutoCompleteCell ()

@property (nonatomic, readwrite) PLFloatingLabelAutoCompleteField *selectField;

@end


@implementation PLFloatingAutoCompleteCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self)
    {
        _selectField = [[PLFloatingLabelAutoCompleteField alloc] initWithFrame:self.bounds];
        [self addSubview:_selectField];
        [_selectField autoPinEdgesToSuperviewEdges];
        _selectField.userInteractionEnabled = NO;
    }
    return self;
    
}

- (void)updateWithModel:(id)model
{
    if ([model isKindOfClass:[PLFormAutoCompleteFieldElement class]])
    {
        [_selectField updateWithElement:model];
    }
}


- (BOOL)canBecomeFirstResponder
{
    return [_selectField canBecomeFirstResponder];
}

- (BOOL)becomeFirstResponder;
{
    return [_selectField becomeFirstResponder];
}

- (BOOL)canResignFirstResponder;
{
    return [_selectField canResignFirstResponder];
}

- (BOOL)resignFirstResponder;
{
    return [_selectField resignFirstResponder];
}

- (BOOL)isFirstResponder;
{
    return [_selectField isFirstResponder];
}

@end
