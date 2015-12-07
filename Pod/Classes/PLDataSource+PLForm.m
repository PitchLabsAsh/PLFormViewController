//
//  PLDataSource+PLForm.m
//  Pitch
//
//  Created by Ashley Thwaites on 05/01/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//


#import "PLDataSource+PLForm.h"

@implementation PLDataSource (PLForm)

-(PLFormElement*)elementWithId:(NSInteger)elementId
{
    NSInteger numSections = self.numberOfSections;
    for (int section = 0; section < numSections; section++)
    {
        NSInteger numItems = [self numberOfItemsInSection:section];
        for (int item = 0; item < numItems; item++)
        {
            PLFormElement *element = [self itemAtIndexPath:[NSIndexPath indexPathForItem:item inSection:section]];
            if ([element isKindOfClass:[PLFormElement class]])
            {
                if (element.elementID == elementId)
                    return element;
            }
        }
    }
    return nil;
}

-(PLCondition*)findFirstFailedCondition
{
    NSInteger numSections = self.numberOfSections;
    for (int section = 0; section < numSections; section++)
    {
        NSInteger numItems = [self numberOfItemsInSection:section];
        for (int item = 0; item < numItems; item++)
        {
            PLFormElement *element = [self itemAtIndexPath:[NSIndexPath indexPathForItem:item inSection:section]];
            if ([element isKindOfClass:[PLFormElement class]])
            {
                PLValidator *validator = (PLValidator*)element.validator;
                PLConditionCollection *failedConditions = [validator checkConditions:element];
                
                if (failedConditions.count != 0)
                {
                    return [failedConditions conditionAtIndex:0];
                }
            }
        }
    }
    return nil;
}

@end
