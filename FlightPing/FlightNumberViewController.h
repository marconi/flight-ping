//
//  FlightNumberViewController.h
//  FlightPing
//
//  Created by Marconi Moreto on 1/21/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@interface FlightNumberViewController : UIViewController {
    RootViewController *delegate;
    IBOutlet UITextField *flightNumber;
}

@property (nonatomic, retain) UITextField *flightNumber;

- (id)delegate;
- (void)setDelegate:(id)newDelegate;

@end
