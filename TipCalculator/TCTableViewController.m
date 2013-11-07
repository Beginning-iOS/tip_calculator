//
//  TCTableViewController.m
//  TipCalculator
//
//  Created by Mark Haskamp on 11/2/13.
//  Copyright (c) 2013 Mark Haskamp. All rights reserved.
//

#import "TCTableViewController.h"
#import "constants.h"


@interface TCTableViewController ()

@end

@implementation TCTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self._billSplits = [[NSMutableArray alloc] initWithObjects:[NSDecimalNumber zero], nil];
    self._tipPercentage = 15;
    
    [self.navigationItem setTitle:@"Tip Calculator"];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(signed char)tableView:(UITableView *)tableView
  canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

-(void) setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
}

-(void)  tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
 forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete) {
        [self._billSplits removeObjectAtIndex:indexPath.row];
        [tableView reloadData];
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self sectionIsTotalBill:section]) {
        return 1;
    }
    if ([self sectionIsTipPercentage:section]) {
        return 1;
    }
    else if ([self sectionIsBillSplits:section]) {
        return [self._billSplits count];
    }
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([self sectionIsTotalBill:indexPath.section]) {
        UITableViewCell *cell = [self buildTotalBillCellForTableView:tableView WithIndexPath:indexPath];
        return cell;
    }
    else if ([self sectionIsBillSplits:indexPath.section]) {
        UITableViewCell *cell = [self buildBillSplitCellForTableView:tableView WithIndexPath:indexPath];
        return cell;
    }
    else if([self sectionIsTipPercentage:indexPath.section]) {
        UITableViewCell *cell = [self buildTipPercentageCellForTableView:tableView WithIndexPath:indexPath];
        return cell;
    }

    return nil;
}

-(UITableViewCell *)buildTotalBillCellForTableView:tableView
                                         WithIndexPath:indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TOTAL_BILL_CELL_ID
                                                            forIndexPath:indexPath];

    return cell;
}

-(UITableViewCell *)buildBillSplitCellForTableView:tableView
                                     WithIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BILL_AMOUNT_CELL_ID
                                                            forIndexPath:indexPath];
    
    int tableRow = indexPath.row;
    UITextField *billAmountField  = (UITextField *)[cell viewWithTag:BILL_AMOUNT_TAG_NUMBER];
    UITextField *tipAmountField   = (UITextField *)[cell viewWithTag:TIP_AMOUNT_TAG_NUMBER];
    UITextField *totalAmountField = (UITextField *)[cell viewWithTag:TOTAL_AMOUNT_TAG_NUMBER];

    NSMutableArray *calculatedBillSplits = [self buildCalculatedBillSplits];
    float fBillAmount = [calculatedBillSplits[tableRow] floatValue];
    
    float fTipAmount = fBillAmount * ((float)self._tipPercentage / 100);
    
    billAmountField.text = [NSString stringWithFormat:@"%.2f", fBillAmount];
    tipAmountField.text = [NSString stringWithFormat:@"%.2f", fTipAmount];
    totalAmountField.text = [NSString stringWithFormat:@"%.2f", (fBillAmount + fTipAmount)];
    
    return cell;
}

-(NSMutableArray *) buildCalculatedBillSplits
{
    NSMutableArray *returnBillSplits = [[NSMutableArray alloc] initWithCapacity:[self._billSplits count]];

    int   autosCount = [self buildAutosCount];
    float manualTotal = [self buildManualTotal];
    
    for (NSDecimalNumber *curSplit in self._billSplits) {
        if (curSplit == [NSDecimalNumber zero]) {
            
            [returnBillSplits addObject:[[NSDecimalNumber alloc]
                                         initWithFloat:((self._totalBillAmount - manualTotal) / autosCount)]];
        }
        else {
            [returnBillSplits addObject:curSplit];
        }
    }
    
    return returnBillSplits;
}

-(int)buildAutosCount
{
    int returnCount = 0;
    for (NSDecimalNumber *curSplit in self._billSplits) {
        if (curSplit == [NSDecimalNumber zero]) {
            returnCount++;
        }
    }
    
    return returnCount;
}

-(float)buildManualTotal
{
    float manualTotal = 0.0;
    for (NSDecimalNumber *curSplit in self._billSplits) {
        if (curSplit != [NSDecimalNumber zero]) {
            manualTotal += [curSplit floatValue];
        }
    }
    
    return manualTotal;
}


-(UITableViewCell *)buildTipPercentageCellForTableView:tableView
                                         WithIndexPath:indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TIP_PERCENTAGE_CELL_ID
                                                            forIndexPath:indexPath];
    
    UILabel *tipPercentageLabel = (UILabel *)[cell viewWithTag:TIP_PERCENTAGE_LABEL_TAG_NUMBER];
    UISlider *tipSlider = (UISlider *)[cell viewWithTag:TIP_PERCENTAGE_SLIDER_TAG_NUMBER];
    tipPercentageLabel.text = [NSString stringWithFormat:@"%d", self._tipPercentage];
    [tipSlider setValue:(float)self._tipPercentage];
    
    return cell;
}

-(bool)sectionIsTotalBill:(NSInteger)section
{
    return (section == 0);
}

-(bool)sectionIsBillSplits:(NSInteger)section {
    return (section == 1);
}

-(bool)sectionIsTipPercentage:(NSInteger)section
{
    return (section == 2);
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView =
    [[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, tableView.frame.size.width, 45.0)];
    headerView.backgroundColor = [UIColor lightGrayColor];

    if ([self sectionIsBillSplits:section]) {

        float frameWidth = headerView.frame.size.width;
        float buttonWidth = 30.0f;
        CGRect buttonFrame = CGRectMake(frameWidth - buttonWidth-20, 0.0f, buttonWidth, 45.0f);
        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [addButton addTarget:self
                      action:@selector(addRowTapped:)
            forControlEvents:UIControlEventTouchUpInside];
        [addButton setTitle:@"Add" forState:UIControlStateNormal];
        addButton.frame = buttonFrame;
        [headerView addSubview:addButton];
        
        CGRect labelFrame = CGRectMake(20.0f, 0.0f, headerView.frame.size.width, 45.0f);
        UILabel *headerLabel = [[UILabel alloc] initWithFrame:labelFrame];
        headerLabel.text = @"Bill Splits";
        headerLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        [headerView addSubview:headerLabel];
        
        return headerView;
    }
    if ([self sectionIsTipPercentage:section]) {

        CGRect labelFrame = CGRectMake(20.0f, 0.0f, headerView.frame.size.width, 45.0f);
        UILabel *headerLabel = [[UILabel alloc] initWithFrame:labelFrame];
        headerLabel.text = @"Tip Percentage";
        headerLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        [headerView addSubview:headerLabel];
        
        return headerView;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([self sectionIsTotalBill:section]) {
        return 0.0;
    }
    return 45.0;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if ([self sectionIsTotalBill:section]) {
        return nil;
    }
/*    else if ([self sectionIsBillSplits:section]) {
        return BILL_SPLITS_SECTION_HEADING;
    } */
    else {
        return TIP_CALCULATOR_SECTION_HEADING;
    }
    
    return @"error";
}

 -(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self sectionIsTotalBill:indexPath.section]) {
        return 50.0;
    }
    else if ([self sectionIsBillSplits:indexPath.section]) {
        return 50.0;
    }
    else if ([self sectionIsTipPercentage:indexPath.section]) {
        return 75.0;
    }
    
    return 0.0;
}

#pragma mark events

- (IBAction)tipSliderValueChanged:(id)sender {
    UISlider *tipPercentageSlider = (UISlider *)sender;
    self._tipPercentage = (int)tipPercentageSlider.value;

    UITableView *tableView = (UITableView *)self.view;
    [tableView reloadData];
}

- (IBAction)presetTap:(id)sender {
    UIButton *presetButton = (UIButton *)sender;
    self._tipPercentage = [presetButton.titleLabel.text intValue];
    [(UITableView *)self.view reloadData];
}

- (IBAction)editTotalBillAmountDidEnd:(id)sender {
    [(UITextField *)sender resignFirstResponder];
}
- (IBAction)splitAmountDidEnd:(id)sender {
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
    int row = indexPath.row;
    
    UITextField *splitAmountField = (UITextField *)sender;
    self._billSplits[row] = [NSDecimalNumber decimalNumberWithString:splitAmountField.text];
}

- (IBAction)CalculateTipTapped:(id)sender {
    NSIndexPath *ndxPath = [NSIndexPath indexPathForRow:0 inSection:0];
    UITableViewCell *cell = [[self tableView] cellForRowAtIndexPath:ndxPath];

    UITextField *totalBillAmountField  = (UITextField *)[cell viewWithTag:TOTAL_BILL_TOTAL_TAG_NUMBER];
    self._totalBillAmount = [totalBillAmountField.text floatValue];
    
    [(UITableView *)self.view reloadData];
}

- (IBAction)addRowTapped:(id)sender
{
    [self._billSplits addObject:[NSDecimalNumber zero]];
    [(UITableView *)self.view reloadData];
}

- (IBAction)deleteRowTapped:(id)sender {
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
    int deletedRow = indexPath.row;
    
    [self._billSplits removeObjectAtIndex:deletedRow];
    [(UITableView *)self.view reloadData];
}



@end
