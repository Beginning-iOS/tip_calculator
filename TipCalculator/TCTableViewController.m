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
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _tipPercentage = 15;
    // 0th element in array is ignored. table display tipslider
    _billAmountsCount = 1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    
    return _billAmountsCount;
}

/*
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 20.0;
    }
    
    return 85.0;
}
 */

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TIP_PERCENTAGE_CELL_ID
                                                                forIndexPath:indexPath];
        
        UILabel *tipPercentageLabel = (UILabel *)[cell viewWithTag:TIP_PERCENTAGE_LABEL_TAG_NUMBER];
        UISlider *tipSlider = (UISlider *)[cell viewWithTag:TIP_PERCENTAGE_SLIDER_TAG_NUMBER];
        tipPercentageLabel.text = [NSString stringWithFormat:@"%d", _tipPercentage];
        [tipSlider setValue:(float)_tipPercentage];
        return cell;
    }

    
    if (indexPath.section == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BILL_AMOUNT_CELL_ID
                                                                forIndexPath:indexPath];
        
        
        UITextField *billAmountField  = (UITextField *)[cell viewWithTag:BILL_AMOUNT_TAG_NUMBER];
        UITextField *tipAmountField   = (UITextField *)[cell viewWithTag:TIP_AMOUNT_TAG_NUMBER];
        UITextField *totalAmountField = (UITextField *)[cell viewWithTag:TOTAL_AMOUNT_TAG_NUMBER];

        float fBillAmount = (_totalBillAmount / (_billAmountsCount));
        float fTipAmount = fBillAmount * ((float)_tipPercentage / 100);

        billAmountField.text = [NSString stringWithFormat:@"%.2f", fBillAmount];
        tipAmountField.text = [NSString stringWithFormat:@"%.2f", fTipAmount];
        totalAmountField.text = [NSString stringWithFormat:@"%.2f", (fBillAmount + fTipAmount)];
        
        if (indexPath.row == 0) {
            // hide delete button
            UIButton *deleteButton  = (UIButton *)[cell viewWithTag:DELETE_ROW_TAG_NUMBER];
            [deleteButton setHidden:YES];
        }
        return cell;
    }

    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 25.0;
    }
    return 50.0;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return nil;
    }
    return TIP_CALCULATOR_TABLE_HEADING;
}

 -(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 90.0;
    }
    
    return 50.0;
}

#pragma mark events

- (IBAction)tipSliderValueChanged:(id)sender {
    UISlider *tipPercentageSlider = (UISlider *)sender;
    _tipPercentage = (int)tipPercentageSlider.value;

    UITableView *tableView = (UITableView *)self.view;
    [tableView reloadData];
}

- (IBAction)presetTap:(id)sender {
    UIButton *presetButton = (UIButton *)sender;
    _tipPercentage = [presetButton.titleLabel.text intValue];
    [(UITableView *)self.view reloadData];
}

- (IBAction)editTotalBillAmountDidEnd:(id)sender {
    [(UITextField *)sender resignFirstResponder];
}

- (IBAction)CalculateTipTapped:(id)sender {
    NSIndexPath *ndxPath = [NSIndexPath indexPathForRow:0 inSection:0];
    UITableViewCell *cell = [[self tableView] cellForRowAtIndexPath:ndxPath];

    UITextField *totalBillAmountField  = (UITextField *)[cell viewWithTag:TOTAL_BILL_TOTAL_TAG_NUMBER];
    _totalBillAmount = [totalBillAmountField.text floatValue];
    
    [(UITableView *)self.view reloadData];
}

- (IBAction)addRowTapped:(id)sender {
    _billAmountsCount++;
    int lastRow = [[self tableView] numberOfRowsInSection:0];
    NSIndexPath *ip = [NSIndexPath indexPathForRow:lastRow inSection:1];
    [[self tableView] insertRowsAtIndexPaths:[NSArray arrayWithObject:ip]
                            withRowAnimation:UITableViewRowAnimationTop];
    
    [(UITableView *)self.view reloadData];
}

- (IBAction)deleteRowTapped:(id)sender {
    _billAmountsCount--;

    int lastRow = [[self tableView] numberOfRowsInSection:0];
    NSIndexPath *ip = [NSIndexPath indexPathForRow:lastRow-1 inSection:1];
    [[self tableView] deleteRowsAtIndexPaths:[NSArray arrayWithObject:ip]
                            withRowAnimation:UITableViewRowAnimationFade];
    
    [(UITableView *)self.view reloadData];
}


@end
