//
//  PLFloatingLabelCell.m
//  Pitch
//
//  Created by Ashley Thwaites on 05/01/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//


#import "PLFloatingLabelCell.h"
#import "PureLayout.h"

@interface PLFloatingLabelCell ()

@property (nonatomic, readwrite) PLFloatingLabelTextField *textField;

@end


@implementation PLFloatingLabelCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self)
    {
        _textField = [[PLFloatingLabelTextField alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:_textField];
        [_textField autoPinEdgesToSuperviewEdges];
        _textField.userInteractionEnabled = NO;
    }
    return self;

}

- (void)updateWithModel:(id)model
{
    if ([model isKindOfClass:[PLFormTextFieldElement class]])
    {
        [_textField updateWithElement:model];
    }
}

- (BOOL)canBecomeFirstResponder
{
    return [_textField canBecomeFirstResponder];
}

- (BOOL)becomeFirstResponder;
{
    return [_textField becomeFirstResponder];
}

- (BOOL)canResignFirstResponder;
{
    return [_textField canResignFirstResponder];
}

- (BOOL)resignFirstResponder;
{
    return [_textField resignFirstResponder];
}

- (BOOL)isFirstResponder;
{
    return [_textField isFirstResponder];
}

@end
