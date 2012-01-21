//
//  DestinationViewController.h
//  FlightPing
//
//  Created by Marconi Moreto on 1/10/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"


@interface DestinationViewController : UIViewController
    <UITableViewDataSource, UITableViewDelegate> {
    NSMutableDictionary *originDestination;
    RootViewController *delegate;
}

- (id)delegate;
- (void)setDelegate:(id)newDelegate;

@end
