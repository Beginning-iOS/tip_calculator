//
//  TCTableViewController.h
//  TipCalculator
//
//  Created by Mark Haskamp on 11/2/13.
//  Copyright (c) 2013 Mark Haskamp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCTableViewController : UITableViewController <UITextFieldDelegate> {
    /*
    int _billAmountsCount;
    int _tipPercentage;
    float _totalBillAmount;
     */
}

@property (nonatomic) int _tipPercentage;
@property (nonatomic) float _totalBillAmount;
@property (nonatomic, strong) NSMutableArray *_billSplits;


-(bool)sectionIsBillSplits:(NSInteger)section;
-(bool)sectionIsTipPercentage:(NSInteger)section;
-(NSMutableArray *)buildCalculatedBillSplits;

@end
