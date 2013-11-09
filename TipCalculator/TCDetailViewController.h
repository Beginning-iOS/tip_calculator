//
//  TCDetailViewController.h
//  TipCalculator
//
//  Created by Mark Haskamp on 11/7/13.
//  Copyright (c) 2013 Mark Haskamp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCDetailViewController : UIViewController

@property(strong, nonatomic) NSString *bill;
@property(strong, nonatomic) NSString *tip;
@property(strong, nonatomic) NSString *total;

@property (weak, nonatomic) IBOutlet UILabel *billLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;

-(float)bumpDown:(float)f;

@end
