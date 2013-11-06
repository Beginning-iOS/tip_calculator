//
//  TipCalculatorTests.m
//  TipCalculatorTests
//
//  Created by Mark Haskamp on 11/2/13.
//  Copyright (c) 2013 Mark Haskamp. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TCTableViewController.h"

@interface TipCalculatorTests : XCTestCase

@end

@implementation TipCalculatorTests {
    TCTableViewController *ctlr;
}

- (void)setUp
{
    [super setUp];

    ctlr = [[TCTableViewController alloc] initWithNibName:@"TCTableViewController" bundle:nil];
    [ctlr viewDidLoad];
}

- (void)tearDown
{
    ctlr = nil;
    [super tearDown];
}


-(void)test_defaultTipPercentageIs_15
{
    XCTAssertEqual(15, ctlr._tipPercentage);
}

-(void)test_hideDeleteButtonRowCountIs_1
{

    NSMutableArray *billSplits = [[NSMutableArray alloc] initWithObjects:[NSDecimalNumber zero], nil];
    ctlr._billSplits = billSplits;
    XCTAssertTrue([ctlr hideDeleteButton]);
}

-(void)test_hideDeleteButtonIsFalseWhenRowCountIsGreaterThan_0
{
    NSMutableArray *billSplits = [[NSMutableArray alloc] initWithObjects:[NSDecimalNumber zero], [NSDecimalNumber zero], nil];
    
    ctlr._billSplits = billSplits;
    XCTAssertFalse([ctlr hideDeleteButton]);
}

-(void)test_sectionsIsBillSplitsIsTrueForSectionIs_1 {
    XCTAssertTrue([ctlr sectionIsBillSplits:1]);
}

-(void)test_sectionsIsTipPercentageIsTrueForSectionIs_2 {
    XCTAssertTrue([ctlr sectionIsTipPercentage:2]);
}

-(void)test_billSplitsArrayHasOneEntryOnInit {
    XCTAssertEqual(1, (int)[ctlr._billSplits count]);
}

-(void)test_billSplitsArrayHasOneEntryOfValue_0_OnInit {
    XCTAssertEqual((float)0, [[ctlr._billSplits lastObject] floatValue]);
}

-(void) test_billSplitAmountIsCalculatedWhenBillSplitAmountIsZero
{
    NSMutableArray *billSplits = [[NSMutableArray alloc] initWithObjects:
                                  [NSDecimalNumber zero],
                                  [NSDecimalNumber zero],
                                  nil];
    
    ctlr._billSplits = billSplits;
    ctlr._totalBillAmount = 42.0;
    
    NSMutableArray *calculatedBillSplits = [ctlr buildCalculatedBillSplits];
    float expected = 21.0;
    float actual = [calculatedBillSplits[0] floatValue];
    XCTAssertEqual(expected, actual, @"item0 should be 21.0");
    XCTAssertEqual((float)21.0, [calculatedBillSplits[1] floatValue], @"item[1] should be 21.0");
}

-(void) test_billSplitAmountIsNotCalculatedWhenBillSplitAmountIsGreaternThanZero
{
    NSMutableArray *billSplits = [[NSMutableArray alloc] initWithObjects:
                                  [[NSDecimalNumber alloc] initWithInt:22],
                                  [[NSDecimalNumber alloc] initWithInt:20],
                                  nil];
    
    ctlr._billSplits = billSplits;
    ctlr._totalBillAmount = 42.0;
    
    NSMutableArray *calculatedBillSplits = [ctlr buildCalculatedBillSplits];
    XCTAssertEqual((float)22.0, [calculatedBillSplits[0] floatValue], @"item0 should be 22.0");
}

-(void) test_billSplitAmountTotalsAddUpToTotalBillAmount
{
    NSMutableArray *billSplits = [[NSMutableArray alloc] initWithObjects:
                                  [NSDecimalNumber zero],
                                  [[NSDecimalNumber alloc] initWithInt:20],
                                  [NSDecimalNumber zero],
                                  nil];
    
    ctlr._billSplits = billSplits;
    ctlr._totalBillAmount = 42.0;
    
    NSMutableArray *calculatedBillSplits = [ctlr buildCalculatedBillSplits];
    XCTAssertEqual((float)11.0, [calculatedBillSplits[0] floatValue]);
}


@end
