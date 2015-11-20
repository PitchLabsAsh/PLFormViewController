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
        _selectField.userInteractionEnabled = NO;
    }
    return self;
    
}

- (void)updateWithModel:(id)model
{
    if ([model isKindOfClass:[PLFormSelectFieldElement class]])
    {
        [_selectField updateWithElement:model];
    }
}


// selectes are inline, so we dont want the selectfield to become the first responder
- (BOOL)canBecomeFirstResponder
{
    return YES;
}

@end
