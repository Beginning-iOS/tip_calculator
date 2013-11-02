//
//  TCTableViewController.h
//  TipCalculator
//
//  Created by Mark Haskamp on 11/2/13.
//  Copyright (c) 2013 Mark Haskamp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCTableViewController : UITableViewController <UITextFieldDelegate> {
    int _billAmountsCount;
    int _tipPercentage;
}

@end
