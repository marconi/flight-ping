//
//  RootViewController.h
//  FlightPing
//
//  Created by Marconi Moreto on 1/10/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlightNumberCell.h"
#import "FlightScheduleCell.h"

@interface RootViewController : UIViewController {
    NSArray *fields;
    int origin, destination;
    IBOutlet FlightNumberCell *flightNumberCell;
    IBOutlet FlightScheduleCell *flightScheduleCell;
}

@property (nonatomic, retain) FlightNumberCell *flightNumberCell;
@property (nonatomic, retain) FlightScheduleCell *flightScheduleCell;

@end
