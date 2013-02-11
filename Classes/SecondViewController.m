//
//  SecondViewController.m
//  SportsBase
//
//  Created by Craig Taub on 17/11/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SecondViewController.h"
#import "FirstViewController.h"

@implementation SecondViewController

@synthesize tableViewController;
@synthesize firstViewController;
@synthesize selectedSportId;

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
	[myTab setSelectedItem:tabTwo]; //set selected item in tab
	
	[tabOne setAction:@selector(pressItem2:)]; //assign function to button click
	
	self.navigationItem.hidesBackButton = YES;//hide back button
	
	searchWord.delegate = self; //show done key
    searchWord.returnKeyType = UIReturnKeyDone; //show done key
	
	//picker array
	/* API call */
	NSString *initialUrl = @"http://localhost/rob_api.php?sports_array=1";
	NSURL *url = [NSURL URLWithString:initialUrl]; //set NSURL
	NSError *theNetworkError; //set NSError 
	NSString *content = [NSString stringWithContentsOfURL:url encoding:NSASCIIStringEncoding error:&theNetworkError]; //query url
	/* decode JSON content..can put into for loop */
	NSString *jsonString = [NSString stringWithString:content]; 
	NSDictionary *dictionary = [jsonString JSONValue];
	/* create array of sports for picker. from API */
	arraySports = [[NSMutableArray alloc] init];
	[arraySports addObject:@""]; //start blank item
	for(NSString *key in dictionary) {
		id value = [dictionary objectForKey:key]; //each value
		for(NSString *keyTwo in value) { //array of each items contents
			if ([keyTwo isEqualToString:@"1"]) { //key of 1 is title...
				id valueTwo = [value objectForKey:keyTwo];
				[arraySports addObject:valueTwo];
			} 
		}
	}
	//required for ids of each value
	arraySportsIds = [[NSMutableArray alloc] init];
	[arraySportsIds addObject:@""]; //start blank item
	for(NSString *keyThree in dictionary) {
		id valueThree = [dictionary objectForKey:keyThree]; //each value
		for(NSString *keyFour in valueThree) { //array of each items contents
			if ([keyFour isEqualToString:@"2"]) { //key of 2 is distance...
				id valueFour = [valueThree objectForKey:keyFour];
				[arraySportsIds addObject:valueFour];
			} 
		}
	}
	
	
	//TESTING TO RESIZE UIPICKERVIEW
	
	/*
	//create your view
	self.view = [[UIView alloc] initWithFrame:CGRectZero];
	// create a default sized pickerView
	pickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
	pickerView.delegate = self;
	pickerView.dataSource = self;
	pickerView.showsSelectionIndicator = YES;
	// Get its frame
	CGRect pickerFrame = pickerView.frame;
	// Set it to what ever you like, I use a default screen height times a shrink factor like 0.75 for 3/4 of its original size
	pickerFrame.size.width = 170;
	pickerFrame.size.height =  110;
	// You can also set the upper left corner of the picker
	pickerFrame.origin.x = 0;
	// Set the picker frame to new size and origin
	pickerView.frame = pickerFrame;
	// Add it to your view
	[self.view addSubview:pickerView];
	 */
	
	/*
	pickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
	pickerView.delegate = self;
	pickerView.dataSource = self;
	pickerView.showsSelectionIndicator = YES;
	pickerView.transform = CGAffineTransformMakeScale(0.5, 0.5);
	self.view = [[UIView alloc] initWithFrame:CGRectZero];
	[self.view addSubview:pickerView];
	*/
	
	//pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 10)];
}


/* picker methods */
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
	return 1;
}
- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
	return [arraySports count];
}
- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	return [arraySports objectAtIndex:row];
}
- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	
	//NSLog(@"Selected Color: %@. Index of selected color: %i", [arraySports objectAtIndex:row], row);// string,int
	NSString *selectedSportId = [arraySportsIds objectAtIndex:row];
	self.selectedSportId = selectedSportId; //important...manage object data into controller so can use inside switchPage.
}
/* end of picker methods */


- (BOOL)textFieldShouldReturn:(UITextField *)textField { //get done key to work
    if (searchWord == searchWord) {
        [searchWord resignFirstResponder];
    } 
    return YES;
}



-(IBAction)switchPage:(id)sender
{
	if([searchWord.text length] == 0){ //validation for text...if empty
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Search" message:@"Enter a postcode"  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		[alert show];
		[alert release];
	} else {
		NSString *string = searchWord.text;
		if ([string rangeOfString:@" "].location == NSNotFound) { //validate if has space in search (i.e. 2 words+)
			if (selectedSportId != NULL){ //if no sport selected
				TableViewController *viewTwo = [[TableViewController alloc]
												initWithNibName:@"TableViewController" bundle:[NSBundle mainBundle]];
				NSString *PassText = searchWord.text; 
				viewTwo.PassText = PassText; //passing var from search to results page
				NSString *searchType = @"sport"; //pass searchType so TableViewController can infer if club or sport.
				viewTwo.searchType = searchType;
				self.tableViewController = viewTwo;
				viewTwo.sportId = selectedSportId;	//set above as self.selectedSportsId
				[viewTwo release];
				[self.navigationController pushViewController:self.tableViewController animated:YES];
			} else {
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Search" message:@"Please select a Sport"  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				[alert show];
				[alert release];
			}
		} else {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Search" message:@"Please remove any spaces"  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			[alert show];
			[alert release];
		}
		
	}
}



-(void)pressItem2:(UITabBarItem *) item1{
	//[self.navigationController popToRootViewControllerAnimated:YES];
	FirstViewController *firstView = [[FirstViewController alloc]
										initWithNibName:@"FirstViewController" bundle:[NSBundle mainBundle]];
	self.firstViewController = firstView;
	[firstView release];
	[self.navigationController pushViewController:self.firstViewController animated:NO];
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
