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

        float fBillAmount = (float)[billAmountField.text floatValue];
        float fTipAmount = fBillAmount * ((float)_tipPercentage / 100);

        tipAmountField.text = [NSString stringWithFormat:@"%.2f", fTipAmount];
        totalAmountField.text = [NSString stringWithFormat:@"%.2f", (fBillAmount + fTipAmount)];
    }
    
    if (indexPath.row == 0) {
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


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
