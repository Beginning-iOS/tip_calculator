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

- (IBAction)tipBumpUpTapped:(id)sender {
    float f = [self bumpUp:[self.tip floatValue]];
    self.tip = [NSString stringWithFormat:@"%.2f", f];
    self.tipLabel.text = [NSString stringWithFormat:@"%.2f", f];
}

- (IBAction)tipBumpDownTapped:(id)sender {
    float f = [self bumpDown:[self.tip floatValue]];
    self.tip = [NSString stringWithFormat:@"%.2f", f];
    self.tipLabel.text = [NSString stringWithFormat:@"%.2f", f];
}

- (IBAction)totalBumpDownTapped:(id)sender {
    float f = [self bumpDown:[self.total floatValue]];
    self.total = [NSString stringWithFormat:@"%.2f", f];
    self.totalLabel.text = [NSString stringWithFormat:@"%.2f", f];
}

- (IBAction)totalBumpUpTapped:(id)sender {
    float f = [self bumpUp:[self.total floatValue]];
    self.total = [NSString stringWithFormat:@"%.2f", f];
    self.totalLabel.text = [NSString stringWithFormat:@"%.2f", f];
}

-(float)bumpDown:(float)f {
    float newF = f - 0.01;
    float modValue = fmod(newF, 0.25);
    return f - (modValue + 0.01);
}

-(float)bumpUp:(float)f
{
    float newF = f + 0.01;
    float modValue = fmod(newF, 0.25);
    return f + 0.01 + (0.25 - modValue);
}



@end
