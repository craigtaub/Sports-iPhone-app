//
//  FirstViewController.m
//  SportsBase
//
//  Created by Craig Taub on 19/11/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FirstViewController.h"
#import "TableViewController.h"
#import "SecondViewController.h"

@implementation FirstViewController


@synthesize tableViewController;
@synthesize secondViewController;


-(IBAction)switchPage:(id)sender
{
	if([searchWord.text length] == 0){ //validation
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Search" message:@"Enter a postcode"  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		[alert show];
		[alert release];
	} else {
		//validate if has space in search (i.e. 2 words+)
		NSString *string = searchWord.text;
		if ([string rangeOfString:@" "].location == NSNotFound) {
			
			//if(self.viewTwoController == nil) { //this was to check if view already loaded
			
			TableViewController *viewTwo = [[TableViewController alloc]
											initWithNibName:@"TableViewController" bundle:[NSBundle mainBundle]];
			NSString *PassText = searchWord.text; 
			viewTwo.PassText = PassText; //passing var from search to results page
			NSString *searchType = @"club"; //pass searchType so TableViewController can infer if club or sport.
			viewTwo.searchType = searchType;
			self.tableViewController = viewTwo;
			[viewTwo release];
			//}
			
			[self.navigationController pushViewController:self.tableViewController animated:YES];
			
		} else {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Search" message:@"Please remove any spaces"  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			[alert show];
			[alert release];
		}
		
	}
}


-(void)pressItem1:(UITabBarItem *) item1{
	SecondViewController *secondView = [[SecondViewController alloc]
										initWithNibName:@"SecondViewController" bundle:[NSBundle mainBundle]];
	self.secondViewController = secondView;
	[secondView release];
	[self.navigationController pushViewController:self.secondViewController animated:NO];
}


// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
    [super viewDidLoad];
	self.navigationItem.title = @"SportsBaseApp";
	[tabOne setTitle:@"By Club"];
	[tabTwo setTitle:@"By Sport"];
	
	[myTab setSelectedItem:tabOne]; //set selected item in tab
	[tabTwo setAction:@selector(pressItem1:)]; //assign function to button click
	[self viewWillAppear:YES];
	self.navigationItem.hidesBackButton = YES;//hide back button
	
	searchWord.delegate = self; //show done key
    searchWord.returnKeyType = UIReturnKeyDone; //show done key

}


- (BOOL)textFieldShouldReturn:(UITextField *)textField { //get done key to work
    if (searchWord == searchWord) {
        [searchWord resignFirstResponder];
    } 
    return YES;
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
