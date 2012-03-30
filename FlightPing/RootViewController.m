//
//  RootViewController.m
//  FlightPing
//
//  Created by Marconi Moreto on 1/10/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "OriginViewController.h"
#import "DestinationViewController.h"
#import "FlightScheduleViewController.h"
#import "FlightScheduleCell.h"
#import "FlightNumberViewController.h"

#import "ASIFormDataRequest.h"
#import "JSON.h"

@implementation RootViewController

@synthesize origin;
@synthesize destination;
@synthesize originStr;
@synthesize destinationStr;
@synthesize mainTable;
@synthesize flightScheduleCell;
@synthesize flightSchedule;
@synthesize flightNumber;

- (void) AlertWithMessage: (NSString *)message {
    /* open an alert with an OK button */
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Flight Ping" 
                          message:message
                          delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles: nil];
    [alert show];
    [alert release];
}

- (IBAction) doSearch {

    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:@"dd MMMM yyyy"];
    NSString *flightDate = [dateFormatter stringFromDate:flightSchedule.date];
    
    NSURL *url = [NSURL URLWithString:@"http://localhost:8000/ping"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setTimeOutSeconds:60];
    [request setPostValue:[NSString stringWithFormat:@"%d", origin] forKey:@"origin"];
    [request setPostValue:[NSString stringWithFormat:@"%d", destination] forKey:@"destination"];
    [request setPostValue:flightDate forKey:@"flightschedule"];
    [request setPostValue:flightNumber forKey:@"flightnumber"];
    [request startSynchronous];
    NSError *error = [request error];
    NSLog(@"%@", error);
    if (!error) {
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSDictionary *response = [parser objectWithString:[request responseString] error:nil];
        NSLog(@"%@", response);
        NSString *msg = [[NSString alloc]
                         initWithFormat:@"Your flight number %@ bound for %@ to %@ is '%@'",
                            [response objectForKey:@"flightNo"],
                            [response objectForKey:@"origin"],
                            [response objectForKey:@"destination"],
                            [response objectForKey:@"status"]];
        [self AlertWithMessage:msg];
    }
    else {
        NSLog(@"%@", error);
    }
    // TODO: this thing shouldn't yiel until the PhantomJS request returns!
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    fields = [[NSArray alloc]
              initWithObjects:@"Origin", @"Destination", @"Flight Number", @"Flight Schedule", nil];
    self.title = @"Flight Ping";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (originStr != nil || destinationStr != nil || flightNumber != nil) {
        [mainTable reloadData];
    }
    flightSchedule.date = [NSDate date];
    NSLog(@"%@", [NSDate date]);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    }
    else {
        return 1;
    }
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    switch ([indexPath row]) {
        case 0:
            // if this is first row, second section, load the DatePicker for schedule.
            if ([indexPath section] == 1) {
                cell = (FlightScheduleCell *)[tableView dequeueReusableCellWithIdentifier:@"flightScheduleCell"];
                if (cell == nil) {
                    [[NSBundle mainBundle] loadNibNamed:@"FlightScheduleCell" owner:self options:nil];
                    cell = flightScheduleCell;
                }
                break;
            }
        default:  // in row 2, 3 and 4
            NSLog(@"%@", flightNumber);
            cell = [tableView dequeueReusableCellWithIdentifier:@"defaultCell"];
            if (cell == nil) {
                cell = [[[UITableViewCell alloc]
                         initWithStyle:UITableViewCellStyleDefault
                         reuseIdentifier:@"defaultCell"] autorelease];
            }

            // origin
            if ([indexPath section] == 0 && [indexPath row] == 0 && originStr != nil) {
                [cell textLabel].text = originStr;
                [cell textLabel].textColor = [UIColor blueColor];
            }

            // destination
            else if ([indexPath section] == 0 && [indexPath row] == 1 && destinationStr != nil) {
                [cell textLabel].text = destinationStr;
                [cell textLabel].textColor = [UIColor blueColor];
            }

            // flight number
            else if ([indexPath section] == 0 && [indexPath row] == 2 && flightNumber != nil) {
                [cell textLabel].text = flightNumber;
                [cell textLabel].textColor = [UIColor blueColor];
            }
            
            // others
            else {
                [cell textLabel].text = [fields objectAtIndex:[indexPath row]];
                [cell textLabel].textColor = [UIColor grayColor];
            }
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;            
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *subViewController;
    switch ([indexPath row]) {
        case 0:  // origin
            subViewController = [[OriginViewController alloc]
                                 initWithNibName:@"OriginViewController" bundle:nil];
            break;
        case 1:  // destination
            subViewController = [[DestinationViewController alloc]
                                 initWithNibName:@"DestinationViewController" bundle:nil];
            break;
        case 2:  // flight number
            subViewController = [[FlightNumberViewController alloc]
                                 initWithNibName:@"FlightNumberViewController" bundle:nil];
            break;
    }

    // push it to navigation
    if ([indexPath row] <= 2) {  // only allow origin, destination and flight number
        [subViewController setDelegate:self];
        [self.navigationController pushViewController:subViewController animated:YES];
        [subViewController release];
    }
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [fields release];
}

- (void)dealloc
{
    [super dealloc];
}

@end
