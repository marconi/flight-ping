//
//  FlightNumberViewController.m
//  FlightPing
//
//  Created by Marconi Moreto on 1/21/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "FlightNumberViewController.h"


@implementation FlightNumberViewController

@synthesize flightNumber;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [flightNumber endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [flightNumber resignFirstResponder];
    delegate.flightNumber = flightNumber.text;
    [[delegate navigationController] popViewControllerAnimated:YES];
    return YES;
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
    self.title = @"Flight Number";
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
