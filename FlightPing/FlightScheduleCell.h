//
//  FlightScheduleCell.h
//  FlightPing
//
//  Created by Marconi Moreto on 1/10/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FlightScheduleCell : UITableViewCell {
    IBOutlet UIDatePicker *datePicker;
}

@property (nonatomic, retain) IBOutlet UIDatePicker *datePicker;

@end
