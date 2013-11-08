//
//  TCDetailViewController.m
//  TipCalculator
//
//  Created by Mark Haskamp on 11/7/13.
//  Copyright (c) 2013 Mark Haskamp. All rights reserved.
//

#import "TCDetailViewController.h"

@interface TCDetailViewController ()


@end


@implementation TCDetailViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.billLabel.text = self.bill;
    self.tipLabel.text = self.tip;
    self.totalLabel.text = self.total;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)foo:(NSString *)s {
    NSLog(@"%@",s);
}

@end
