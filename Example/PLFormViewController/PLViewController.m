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
    
//    self.showPickersInline = NO;
    // lets add a simple form with a bunch of components
    // create the form
    
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:5];
    UIImage *smiley = [UIImage imageNamed:@"Smiley_Face"];
    for (int i=0;i<5;i++)
    {
        NSString *title = [NSString stringWithFormat:@"Option - %d",i];
        [items addObject:[PLFormSelectFieldItem selectItemWithTitle:[title uppercaseString] value:title image:smiley]];
    }
    
//    PLConditionPresent *present = [[PLConditionPresent alloc] initWithLocalizedViolationString:NSLocalizedString(@"Please complete all fields", @"Please complete all fields")];
    PLFormTextFieldElement *nameElement = [PLFormTextFieldElement textInputElementWithID:0 placeholderText:@"Event name" value:nil delegate:self];
    PLFormDateFieldElement *dateElement = [PLFormDateFieldElement datePickerElementWithID:1 title:@"Event date" date:nil datePickerMode:UIDatePickerModeDate delegate:self];
    PLFormDateFieldElement *timeElement = [PLFormDateFieldElement datePickerElementWithID:2 title:@"Event time" date:nil datePickerMode:UIDatePickerModeTime delegate:self];
    PLFormSelectFieldElement *repeatElement = [PLFormSelectFieldElement selectElementWithID:3 title:@"Repeat interval" values:@[@"Never",@"Weelky",@"Monthly"] index:0 delegate:self];
    PLFormSelectFieldElement *selectFieldElement2 = [PLFormSelectFieldElement selectElementWithID:2 title:@"Select Option" items:items index:0 delegate:self];
    PLFormSwitchFieldElement *weeksElemet = [PLFormSwitchFieldElement switchFieldElementWithID:5 title:@"Display weeks" value:NO delegate:self];
    PLFormSwitchFieldElement *lightElemet = [PLFormSwitchFieldElement switchFieldElementWithID:7 title:@"Light theme" value:NO delegate:self];
    PLFormAutoCompleteFieldElement *autoCompleteElement = [PLFormAutoCompleteFieldElement selectElementWithID:1 placeholderText:@"Select Option" values:@[@"Dog",@"Cat",@"Rabbity Rabbit",@"Horse",@"Dog",@"Cat",@"Rabbit",@"Horse",@"Dog",@"Cat",@"Rabbit",@"Horse"] delegate:self];
    autoCompleteElement.displayAllWhenBlank = YES;
    

    
    
    PLMemoryDataSource *memDataSource = [PLMemoryDataSource new];
    self.dataSource = memDataSource;
    
    [memDataSource addItems:@[nameElement,dateElement,timeElement,repeatElement]];
    [memDataSource addItems:@[selectFieldElement2,weeksElemet,lightElemet,autoCompleteElement] toSection:1];
    
    [memDataSource setSectionHeaderModel:@"Section1" forSectionIndex:0];
    [memDataSource setSectionHeaderModel:@"Section2" forSectionIndex:1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)formElementDidChangeValue:(PLFormElement *)formElement;
{
    // if this is a select with items, then its nice to consider the selection complete and remove the item
    if (self.showPickersInline)
    {
        NSIndexPath *path = [self.dataSource indexPathForItem:formElement];
        if (path)
        {
            [super tableView:self.tableView didSelectRowAtIndexPath:path];
        }
    }
}

@end
