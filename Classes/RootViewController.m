//
//  RootViewController.m
//  NavApp
//
//  Created by Wess Cope on 3/23/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "FirstViewController.h"

@implementation RootViewController

@synthesize firstViewController;
/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/


// Implement loadView to create a view hierarchy programmatically, without using a nib.
/*
- (void)loadView {
	
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
//NOTE -> only happens when the view needs to be reloaded. If the view is still in memory it's not necessary.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationItem.title = @"SportsBaseApp";

	//wait 2 secs, run loadApp
	[NSTimer scheduledTimerWithTimeInterval:3.0
									 target:self
								   selector:@selector(loadApp)
								   userInfo:nil
									repeats:NO];
}

-(void)loadApp {
	//runs UIViewController to start app.
	FirstViewController *firstView = [[FirstViewController alloc]
									  initWithNibName:@"FirstViewController" bundle:[NSBundle mainBundle]];
	//XIB requires FirstViewController inside FileOwner class name, so can ref it.
	self.firstViewController = firstView;
	[firstView release];
	[self.navigationController pushViewController:self.firstViewController animated:YES];
	
}


-(IBAction)switchPage:(id)sender{
	NSLog(@"clicked");
	FirstViewController *firstView = [[FirstViewController alloc]
									  initWithNibName:@"FirstViewController" bundle:[NSBundle mainBundle]];
	self.firstViewController = firstView;
	[firstView release];
	[self.navigationController pushViewController:self.firstViewController animated:YES];
}





/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
}


@end
