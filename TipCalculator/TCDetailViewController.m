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
    
    [self paintLabels];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tipBumpUpTapped:(id)sender {
    float f = [self bumpUp:self.tip];
    
    self.total = self.total + (f - self.tip);
    self.tip = f;

    [self paintLabels];
}

- (IBAction)tipBumpDownTapped:(id)sender {
    float f = [self bumpDown:self.tip];
    
    self.total = self.total - (self.tip - f);
    self.tip = f;

    [self paintLabels];
}

- (IBAction)totalBumpDownTapped:(id)sender {
    float f = [self bumpDown:self.total];
    
    self.tip = self.tip - (self.total - f);
    self.total = f;

    [self paintLabels];
}

- (IBAction)totalBumpUpTapped:(id)sender {
    float f = [self bumpUp:self.total];
    self.tip = self.tip + (f - self.total);
    self.total = f;

    [self paintLabels];
}

-(void)paintLabels
{
    self.billLabel.text = [NSString stringWithFormat:@"%.2f", self.bill];
    self.totalLabel.text = [NSString stringWithFormat:@"%.2f", self.total];
    self.tipLabel.text = [NSString stringWithFormat:@"%.2f", self.tip];
    self.percentageLabel.text = [NSString stringWithFormat:@"%.2f", (100 *(self.tip / self.bill))];
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
