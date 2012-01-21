//
//  RootViewController.h
//  FlightPing
//
//  Created by Marconi Moreto on 1/10/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlightScheduleCell.h"


@interface RootViewController : UIViewController {
    NSArray *fields;
    int origin, destination;
    NSString *originStr, *destinationStr, *flightNumber;
    IBOutlet UITableView *mainTable;
    IBOutlet FlightScheduleCell *flightScheduleCell;
    IBOutlet UIDatePicker *flightSchedule;
}

@property (nonatomic, readwrite) int origin;
@property (nonatomic, readwrite) int destination;
@property (nonatomic, retain) NSString *originStr;
@property (nonatomic, retain) NSString *destinationStr;
@property (nonatomic, retain) NSString *flightNumber;
@property (nonatomic, retain) UITableView *mainTable;
@property (nonatomic, retain) FlightScheduleCell *flightScheduleCell;
@property (nonatomic, retain) UIDatePicker *flightSchedule;

- (IBAction) doSearch;
- (void) AlertWithMessage: (NSString *)message;

@end
