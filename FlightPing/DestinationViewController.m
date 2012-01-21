//
//  DestinationViewController.m
//  FlightPing
//
//  Created by Marconi Moreto on 1/10/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "DestinationViewController.h"


@implementation DestinationViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return [[originDestination objectForKey:@"Domestic"] count];
    }
    else {
        return [[originDestination objectForKey:@"International"] count];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Domestic";
    }
    else {
        return @"International";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:@"cell"];
    }
    
    NSString *section;
    if ([indexPath section] == 0) {
        section = @"Domestic";
    }
    else {
        section = @"International";
    }
    
    [cell textLabel].text = [[[[originDestination objectForKey:section] allValues]
                              sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)]
                             objectAtIndex:[indexPath row]];
    [section release];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *section;
    if ([indexPath section] == 0) {
        section = @"Domestic";
    }
    else {
        section = @"International";
    }
    
    NSArray *sectionDict = [[[originDestination objectForKey:section] allValues]
                            sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    NSString *originStr = [sectionDict objectAtIndex:[indexPath row]];
    NSArray *originId = [[originDestination objectForKey:section] allKeysForObject:originStr];
    
    NSLog(@"%@", sectionDict);
    NSLog(@"%@", originStr);
    
    delegate.destination = [[originId objectAtIndex:0] intValue];
    delegate.destinationStr = originStr;
    
    [section release];
    [[delegate navigationController] popViewControllerAnimated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (id)delegate {
    return delegate;
}

- (void)setDelegate:(id)newDelegate {
    delegate = newDelegate;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Destination";

    NSString *originDestinationFile = [[NSBundle mainBundle]
                                       pathForResource:@"OriginDestination"
                                       ofType:@"plist"];
    originDestination = [[[NSMutableDictionary alloc]
                          initWithContentsOfFile:originDestinationFile]
                         objectForKey:@"Root"];
    NSLog(@"%@", originDestination);
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
