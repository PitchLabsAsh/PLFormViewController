//
//  PLViewController.m
//  PLFormViewController
//
//  Created by Ash Thwaites on 11/17/2015.
//  Copyright (c) 2015 Ash Thwaites. All rights reserved.
//

#import "PLViewController.h"
@import PLForm;

@interface PLViewController () <PLFormElementDelegate>

@end

@implementation PLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // lets add a simple form with a bunch of components
    // create the form
    PLConditionPresent *present = [[PLConditionPresent alloc] initWithLocalizedViolationString:NSLocalizedString(@"Please complete all fields", @"Please complete all fields")];
    PLFormTextFieldElement *nameElement = [PLFormTextFieldElement textInputElementWithID:0 placeholderText:@"Event name" value:nil delegate:self];
    PLFormDateFieldElement *dateElement = [PLFormDateFieldElement datePickerElementWithID:1 title:@"Event date" date:nil datePickerMode:UIDatePickerModeDate delegate:self];
    PLFormDateFieldElement *timeElement = [PLFormDateFieldElement datePickerElementWithID:2 title:@"Event time" date:nil datePickerMode:UIDatePickerModeTime delegate:self];
    PLFormSelectFieldElement *repeatElement = [PLFormSelectFieldElement selectElementWithID:3 title:@"Repeat interval" values:@[@"Never",@"Weelky",@"Monthly"] index:0 delegate:self];
    PLFormSelectFieldElement *repeatFormatElement = [PLFormSelectFieldElement selectElementWithID:4 title:@"Repeat format" values:@[@"Since first",@"Since last",@"Until next"] index:0 delegate:self];
    PLFormSwitchFieldElement *weeksElemet = [PLFormSwitchFieldElement switchFieldElementWithID:5 title:@"Display weeks" value:NO delegate:self];
    PLFormSwitchFieldElement *lightElemet = [PLFormSwitchFieldElement switchFieldElementWithID:7 title:@"Light theme" value:NO delegate:self];
    
    
    PLMemoryDataSource *memDataSource = [PLMemoryDataSource new];
    self.dataSource = memDataSource;
    
    [memDataSource addItems:@[nameElement,dateElement,timeElement,repeatElement]];
    [memDataSource addItems:@[repeatFormatElement,weeksElemet,lightElemet] toSection:1];
    
//    DTSectionModel *mainSection = (DTSectionModel*)self.memoryStorage.sections[0];
//    [mainSection setTableSectionHeader:@"Event details"];
//    
//    DTSectionModel *displaySection = (DTSectionModel*)self.memoryStorage.sections[1];
//    [displaySection setTableSectionHeader:@"Display details"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
