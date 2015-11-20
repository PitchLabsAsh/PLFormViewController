//
//  PLFloatingAutoCompleteCell.h
//  Pitch
//
//  Created by Ashley Thwaites on 05/01/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//


@import Foundation;
@import UIKit;
@import PLTableManager;
@import PLForm;


@interface PLFloatingAutoCompleteCell : UITableViewCell <PLModelTransfer>

@property (nonatomic, readonly) PLFloatingLabelAutoCompleteField *selectField;

@end
