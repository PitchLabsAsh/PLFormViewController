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
#import "PLFloatingAutoCompleteCell.h"
#import "PLSwitchCell.h"
#import "PLFormInlineViewCell.h"

@import PLForm;

@interface PLTableViewController ()

- (void)setupTableViewControllerDefaults;

@end

@interface PLFormViewController ()
{
    NSIndexPath *currentInlineIndexPath;
    NSMutableDictionary *inlineViews;
}

@end

@implementation PLFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    inlineViews = [NSMutableDictionary dictionaryWithCapacity:10];
    [self.cellFactory registerCellClass:[PLFormInlineViewCell class] forModelClass:[UIDatePicker class]];
    [self.cellFactory registerCellClass:[PLFormInlineViewCell class] forModelClass:[UIPickerView class]];
    
    // register all the cell class types
    [self.cellFactory registerCellClass:[PLFloatingLabelCell class] forModelClass:[PLFormTextFieldElement class]];
    [self.cellFactory registerCellClass:[PLFloatingDateCell class] forModelClass:[PLFormDateFieldElement class]];
    [self.cellFactory registerCellClass:[PLFloatingSelectCell class] forModelClass:[PLFormSelectFieldElement class]];
    [self.cellFactory registerCellClass:[PLFloatingAutoCompleteCell class] forModelClass:[PLFormAutoCompleteFieldElement class]];
    [self.cellFactory registerCellClass:[PLSwitchCell class] forModelClass:[PLFormSwitchFieldElement class]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupTableViewControllerDefaults
{
    // the default animations used on data source changes
    [super setupTableViewControllerDefaults];
    self.deleteRowAnimation = UITableViewRowAnimationFade;
    self.insertRowAnimation = UITableViewRowAnimationFade;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


// handle the inline insertion delegates
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
{
    // floating date cells we need to remove the gesture recogniser and retain the date picker
    if ([cell isKindOfClass:[PLFloatingDateCell class]])
    {
        PLFloatingDateCell *floatingDateCell = (PLFloatingDateCell*)cell;
        for (UIGestureRecognizer *recogniser in floatingDateCell.dateField.gestureRecognizers)
        {
            [floatingDateCell.dateField removeGestureRecognizer:recogniser];
        }
        
        // if we have a view already for this index we probably need to replace it on the cell..
        [inlineViews setObject:floatingDateCell.dateField.datePicker forKey:indexPath];
    }
    
    if ([cell isKindOfClass:[PLFloatingSelectCell class]])
    {
        PLFloatingSelectCell *floatingSelectCell = (PLFloatingSelectCell*)cell;
        for (UIGestureRecognizer *recogniser in floatingSelectCell.selectField.gestureRecognizers)
        {
            [floatingSelectCell.selectField removeGestureRecognizer:recogniser];
        }
        
        // if we have a view already for this index we probably need to replace it on the cell..
        [inlineViews setObject:floatingSelectCell.selectField.pickerView forKey:indexPath];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id model = [self.dataSource itemAtIndexPath:indexPath];
    if ([model isKindOfClass:[UIView class]])
    {
        return 216.0f;
    }
    
    return self.tableView.rowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id model = [self.dataSource itemAtIndexPath:indexPath];
    if ([model isKindOfClass:[UIView class]])
    {
        return 216.0f;
    }
    
    return self.tableView.rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // correct the index path if we have a current inline cell
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (currentInlineIndexPath)
    {
        if (currentInlineIndexPath.section == indexPath.section)
        {
            if (currentInlineIndexPath.row<indexPath.row)
            {
                indexPath = [NSIndexPath indexPathForRow:indexPath.row-1
                                               inSection:indexPath.section];
            }
        }
    }
    
    if (inlineViews[indexPath])
    {
        if ([currentInlineIndexPath isEqual:indexPath])
        {
            [self removeInlineViewFromIndexPath:indexPath];
        }
        else
        {
            if (currentInlineIndexPath)
            {
                [self removeInlineViewFromIndexPath:currentInlineIndexPath];
            }
            if ([selectedCell canBecomeFirstResponder])
            {
                [self insertInlineViewForIndexPath:indexPath];
                [selectedCell becomeFirstResponder];
            }
        }
    }
    else
    {
        if ([selectedCell canBecomeFirstResponder])
        {
            if (currentInlineIndexPath)
            {
                [self removeInlineViewFromIndexPath:currentInlineIndexPath];
            }
            [selectedCell becomeFirstResponder];
        }
    }
}

#pragma mark - adding and removing picker
-(PLMemoryDataSource*)memoryDataSource
{
    if ([self.dataSource isKindOfClass:[PLMemoryDataSource class]])
        return (PLMemoryDataSource*)self.dataSource;
    return nil;
}

- (void)insertInlineViewForIndexPath:(NSIndexPath *)indexPath
{
    UIView *presenter = inlineViews[indexPath];
    
    NSIndexPath *insertIndexPath = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section];
    [self.memoryDataSource insertItem:presenter toIndexPath:insertIndexPath];
    
    // check if we need to scroll
    UITableViewCell *insertingCell = [self.tableView cellForRowAtIndexPath:indexPath];
    CGFloat inlineBottom = insertingCell.frame.origin.y + insertingCell.frame.size.height + presenter.bounds.size.height;
    if (inlineBottom > self.tableView.bounds.size.height - self.tableView.contentInset.top)
    {
        // to get a smooth scroll animation smooth we need to reload the table immediatly
        // the downside is we loose the insert animation..
        [self.tableView reloadData];
        double y = self.tableView.contentSize.height - self.tableView.bounds.size.height;
        CGPoint bottomOffset = CGPointMake(0,y);
        [self.tableView setContentOffset:bottomOffset animated:YES];
    }
    
    
    currentInlineIndexPath = indexPath;
}

-(NSIndexPath*)lastIndexPath{
    PLDataSourceSection *section = [self.dataSource.sections lastObject];
    if (section == nil)
    {
        return nil;
    }
    
    return [NSIndexPath indexPathForRow:section.objects.count-1 inSection:self.dataSource.sections.count-1];
}

- (void)removeInlineViewFromIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath * pickerIndexPath = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section];
    [self.memoryDataSource removeItem:[self.memoryDataSource itemAtIndexPath:pickerIndexPath]];
    currentInlineIndexPath = nil;
    
    // for some reason removing a cell causes a section seperator line to appear
    
    NSIndexPath *lastPath = [self lastIndexPath];
    UITableViewCell *lastCell = [self.tableView cellForRowAtIndexPath:lastPath];
    for (UIView *view in lastCell.subviews)
    {
        if ((view.bounds.size.width == lastCell.bounds.size.width) &&
            (view != lastCell.contentView))
        {
            view.hidden = YES;
        }
    }
}


@end
