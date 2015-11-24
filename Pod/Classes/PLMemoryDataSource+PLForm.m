//
//  PLMemoryDataSource+PLForm.m
//  Pitch
//
//  Created by Ashley Thwaites on 05/01/2015.
//  Copyright (c) 2015 Pitch Labs. All rights reserved.
//


#import "PLMemoryDataSource+PLForm.h"

@implementation PLMemoryDataSource (PLForm)

-(PLFormElement*)elementWithId:(NSInteger)elementId
{
    for (PLDataSourceSection *section in self.sections)
    {
        for (PLFormElement *element in section.objects)
        {
            if ([element isKindOfClass:[PLFormElement class]])
            {
                if (element.elementID == elementId)
                    return element;
            }
        }
    }
    return nil;
}

@end
