//
//  OriginViewController.h
//  FlightPing
//
//  Created by Marconi Moreto on 1/10/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface OriginViewController : UIViewController
    <UITableViewDataSource, UITableViewDelegate> {
    NSMutableDictionary *originDestination;
    int origin;
}

@end
