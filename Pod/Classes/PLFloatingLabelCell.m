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
        [self addSubview:_textField];
        [_textField autoPinEdgesToSuperviewEdges];
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

@end
