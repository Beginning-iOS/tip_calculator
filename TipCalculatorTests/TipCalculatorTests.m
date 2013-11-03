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

- (void)test_defaultValueFor_billAmountsCountIs_1
{
    XCTAssertEqual(1, ctlr._billAmountsCount);
}

-(void)test_defaultTipPercentageIs_15
{
    XCTAssertEqual(15, ctlr._tipPercentage);
}

-(void)test_hideDeleteButtonIsTrueWhenRowIs_0
{
    XCTAssertTrue([ctlr hideDeleteButtonForRow:0]);
}

-(void)test_hideDeleteButtonIsFalseWhenRowIsGreaterThan_0
{
    XCTAssertFalse([ctlr hideDeleteButtonForRow:1]);
}

-(void)test_sectionsIsBillSplitsIsTrueForSectionIs_1 {
    XCTAssertTrue([ctlr sectionIsBillSplits:1]);
}

-(void)test_sectionsIsTipPercentageIsTrueForSectionIs_0 {
    XCTAssertTrue([ctlr sectionIsTipPercentage:0]);
}



@end
