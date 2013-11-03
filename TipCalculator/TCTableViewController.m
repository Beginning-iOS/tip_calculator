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
    _billAmountsCount = 2;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _billAmountsCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellId;

    if (indexPath.row > 0) {
        CellId = BILL_AMOUNT_CELL_ID;
    }
    else if (indexPath.row == 0) {
        CellId = TIP_PERCENTAGE_CELL_ID;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId
                                                            forIndexPath:indexPath];
    
    if (indexPath.row > 0) {
        UITextField *billAmountField  = (UITextField *)[cell viewWithTag:BILL_AMOUNT_TAG_NUMBER];
        UITextField *tipAmountField   = (UITextField *)[cell viewWithTag:TIP_AMOUNT_TAG_NUMBER];
        UITextField *totalAmountField = (UITextField *)[cell viewWithTag:TOTAL_AMOUNT_TAG_NUMBER];

        float fBillAmount = (_totalBillAmount / (_billAmountsCount - 1));
        float fTipAmount = fBillAmount * ((float)_tipPercentage / 100);

        billAmountField.text = [NSString stringWithFormat:@"%.2f", fBillAmount];
        tipAmountField.text = [NSString stringWithFormat:@"%.2f", fTipAmount];
        totalAmountField.text = [NSString stringWithFormat:@"%.2f", (fBillAmount + fTipAmount)];
    }
    else if (indexPath.row == 0) {
        UILabel *tipPercentageLabel = (UILabel *)[cell viewWithTag:TIP_PERCENTAGE_LABEL_TAG_NUMBER];
        UISlider *tipSlider = (UISlider *)[cell viewWithTag:TIP_PERCENTAGE_SLIDER_TAG_NUMBER];
        tipPercentageLabel.text = [NSString stringWithFormat:@"%d", _tipPercentage];
        [tipSlider setValue:(float)_tipPercentage];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 95.0;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return TIP_CALCULATOR_TABLE_HEADING;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 85.0;
    }
    
    return 65.0;
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
    NSIndexPath *ip = [NSIndexPath indexPathForRow:lastRow inSection:0];
    [[self tableView] insertRowsAtIndexPaths:[NSArray arrayWithObject:ip]
                            withRowAnimation:UITableViewRowAnimationTop];
    
    [(UITableView *)self.view reloadData];
}

- (IBAction)deleteRowTapped:(id)sender {
    _billAmountsCount--;

    int lastRow = [[self tableView] numberOfRowsInSection:0];
    NSIndexPath *ip = [NSIndexPath indexPathForRow:lastRow-1 inSection:0];
    [[self tableView] deleteRowsAtIndexPaths:[NSArray arrayWithObject:ip]
                            withRowAnimation:UITableViewRowAnimationFade];
    
    [(UITableView *)self.view reloadData];
}


@end
