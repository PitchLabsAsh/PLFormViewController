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

@interface PLTableViewController () <UIGestureRecognizerDelegate>

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
    
    _showPickersInline = YES;
    inlineViews = [NSMutableDictionary dictionaryWithCapacity:10];
    [self.cellFactory registerCellClass:[PLFormInlineViewCell class] forModelClass:[UIDatePicker class]];
    [self.cellFactory registerCellClass:[PLFormInlineViewCell class] forModelClass:[UIPickerView class]];
    [self.cellFactory registerCellClass:[PLFormInlineViewCell class] forModelClass:[UICollectionView class]];
    
    // register all the cell class types
    [self.cellFactory registerCellClass:[PLFloatingLabelCell class] forModelClass:[PLFormTextFieldElement class]];
    [self.cellFactory registerCellClass:[PLFloatingDateCell class] forModelClass:[PLFormDateFieldElement class]];
    [self.cellFactory registerCellClass:[PLFloatingSelectCell class] forModelClass:[PLFormSelectFieldElement class]];
    [self.cellFactory registerCellClass:[PLFloatingAutoCompleteCell class] forModelClass:[PLFormAutoCompleteFieldElement class]];
    [self.cellFactory registerCellClass:[PLSwitchCell class] forModelClass:[PLFormSwitchFieldElement class]];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    tapGesture.delegate = self;
    [self.tableView addGestureRecognizer:tapGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView*)findFirstResponderBeneathView:(UIView*)view {
    // Search recursively for first responder
    for ( UIView *childView in view.subviews ) {
        if ( [childView respondsToSelector:@selector(isFirstResponder)] && [childView isFirstResponder] ) return childView;
        UIView *result = [self findFirstResponderBeneathView:childView];
        if ( result ) return result;
    }
    return nil;
}

- (void)handleTap:(UIGestureRecognizer*)sender
{
    // we tapped somewhere outside a cell..
    UIView *responder = [self findFirstResponderBeneathView:self.tableView];
    if (responder)
        [responder resignFirstResponder];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch;
{
    CGPoint point = [touch locationInView:self.tableView];
    NSIndexPath* index = [self.tableView indexPathForRowAtPoint:point];
    
    // There seems to be a small bug in indexPathForRowAtPoint becuase it taps inside
    // the last section header / footer return a cell, so we need to double check
    // the tap is actually in the cell it says it was
    if (index)
    {
        UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:index];
        point = [touch locationInView:cell];
        
        if (point.y < 0 || point.y >= cell.frame.size.height) {
            index = nil;
        }
    }
    
    return index == nil;
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

-(NSIndexPath*)pathCorrectedForInlineView:(NSIndexPath*)indexPath
{
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
    return indexPath;
}


// handle the inline insertion delegates
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
{
    // if we are not inlineing pickers then dont remove the gestures
    if (!_showPickersInline)
        return;
    
    // floating date cells we need to remove the gesture recogniser and retain the date picker
    if ([cell isKindOfClass:[PLFloatingDateCell class]])
    {
        PLFloatingDateCell *floatingDateCell = (PLFloatingDateCell*)cell;
        for (UIGestureRecognizer *recogniser in floatingDateCell.dateField.gestureRecognizers)
        {
            [floatingDateCell.dateField removeGestureRecognizer:recogniser];
        }
        
        // if we have a view already for this index we probably need to replace it on the cell..
        [inlineViews setObject:floatingDateCell.dateField.datePicker forKey:[self pathCorrectedForInlineView:indexPath]];
    }
    
    // same with inline select fields
    if ([cell isKindOfClass:[PLFloatingSelectCell class]])
    {
        PLFloatingSelectCell *floatingSelectCell = (PLFloatingSelectCell*)cell;
        for (UIGestureRecognizer *recogniser in floatingSelectCell.selectField.gestureRecognizers)
        {
            [floatingSelectCell.selectField removeGestureRecognizer:recogniser];
        }
        
        // if we have a view already for this index we probably need to replace it on the cell..
        if (floatingSelectCell.selectField.element.items)
            [inlineViews setObject:floatingSelectCell.selectField.collectionView forKey:[self pathCorrectedForInlineView:indexPath]];
        else
            [inlineViews setObject:floatingSelectCell.selectField.pickerView forKey:[self pathCorrectedForInlineView:indexPath]];
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
    
    NSIndexPath *correctedPath = [self pathCorrectedForInlineView:indexPath];
    if (inlineViews[correctedPath])
    {
        if ([currentInlineIndexPath isEqual:correctedPath])
        {
            [self removeInlineViewFromIndexPath:correctedPath];
        }
        else
        {
            if (currentInlineIndexPath)
            {
                [self removeInlineViewFromIndexPath:currentInlineIndexPath];
            }
            if ([selectedCell canBecomeFirstResponder])
            {
                [self insertInlineViewForIndexPath:correctedPath];
            }
        }
    }
    else
    {
        if ([selectedCell isFirstResponder])
        {
            [selectedCell resignFirstResponder];
        }
        else if ([selectedCell canBecomeFirstResponder])
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
    NSInteger numSections = [self.dataSource numberOfSections];
    NSInteger numItems = [self.dataSource numberOfItemsInSection:numSections-1];
    return [NSIndexPath indexPathForRow:numItems-1 inSection:numSections-1];
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
