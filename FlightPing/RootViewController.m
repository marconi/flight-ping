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
#import "FlightNumberCell.h"
#import "FlightScheduleCell.h"

@implementation RootViewController

@synthesize flightNumberCell;
@synthesize flightScheduleCell;

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
        case 2:
            cell = (FlightNumberCell *)[tableView dequeueReusableCellWithIdentifier:@"flightNumberCell"];
            if (cell == nil) {
                [[NSBundle mainBundle] loadNibNamed:@"FlightNumberCell" owner:self options:nil];
                cell = flightNumberCell;
            }
            break;
        case 0:
            if ([indexPath section] == 1) {
                cell = (FlightScheduleCell *)[tableView dequeueReusableCellWithIdentifier:@"flightScheduleCell"];
                if (cell == nil) {
                    [[NSBundle mainBundle] loadNibNamed:@"FlightScheduleCell" owner:self options:nil];
                    cell = flightScheduleCell;
                }
                break;
            }
        default:
            cell = [tableView dequeueReusableCellWithIdentifier:@"defaultCell"];
            if (cell == nil) {
                cell = [[[UITableViewCell alloc]
                         initWithStyle:UITableViewCellStyleDefault
                         reuseIdentifier:@"defaultCell"] autorelease];
                [cell textLabel].text = [fields objectAtIndex:[indexPath row]];
                [cell textLabel].textColor = [UIColor grayColor];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            break;
    }
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id subViewController;
    switch ([indexPath row]) {
        case 0:  // origin
            subViewController = [[OriginViewController alloc]
                                 initWithNibName:@"OriginViewController" bundle:nil];
            break;
        case 1:
            subViewController = [[DestinationViewController alloc]
                                 initWithNibName:@"DestinationViewController" bundle:nil];
            break;
    }
    
    // push it to navigation
    if ([indexPath row] <= 1) {
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

    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc
{
    [super dealloc];
}

@end
