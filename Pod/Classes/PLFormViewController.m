//
//  PLFormViewController.m
//  Pitch
//
//  Created by Ashley Thwaites on 05/01/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//


#import "PLFormViewController.h"
#import "PLFloatingLabelCell.h"
#import "PLFloatingDateCell.h"
#import "PLFloatingSelectCell.h"
#import "PLSwitchCell.h"

@import PLForm;


@interface PLFormViewController ()

@end

@implementation PLFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self registerCellClass:[PLFormInlineViewCell class] forModelClass:[UIDatePicker class]];
//    [self registerCellClass:[PLFormInlineViewCell class] forModelClass:[UIPickerView class]];
    
    // register all the cell class types
    [self.cellFactory registerCellClass:[PLFloatingLabelCell class] forModelClass:[PLFormTextFieldElement class]];
    [self.cellFactory registerCellClass:[PLFloatingDateCell class] forModelClass:[PLFormDateFieldElement class]];
    [self.cellFactory registerCellClass:[PLFloatingSelectCell class] forModelClass:[PLFormSelectFieldElement class]];
    [self.cellFactory registerCellClass:[PLSwitchCell class] forModelClass:[PLFormSwitchFieldElement class]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// handle the inline insertion delegates


@end
