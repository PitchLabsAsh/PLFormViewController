//
//  PLDataSource+PLForm.h
//  Pitch
//
//  Created by Ashley Thwaites on 05/01/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//


#import <Foundation/Foundation.h>
@import PLForm;
@import PLTableManager;

@interface PLDataSource (PLForm)

-(PLFormElement*)elementWithId:(NSInteger)elementId;
-(PLCondition*)findFirstFailedCondition;

@end
