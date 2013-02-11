//
//  ViewTwoController.m
//  NavApp
//
//  Created by Wess Cope on 3/23/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ViewTwoController.h"
#import "JSON.h" 

@implementation ViewTwoController

@synthesize label;
@synthesize labelTwo;
@synthesize labelThree;
@synthesize PassText;
@synthesize PassId;
@synthesize ClickValue;

@synthesize detailsDist;
@synthesize detailsLoc;
@synthesize detailsSite;
@synthesize detailsAddress;
@synthesize detailsSports;
@synthesize detailsPhone;
@synthesize postcode;
/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	 
	NSString *NewClickValue=[ClickValue stringByAppendingFormat:@" Details"];
	self.navigationItem.title = NewClickValue;
	labelThree.text = PassId;
	labelTwo.text = PassText; //passed from initial search
	label.text = ClickValue; //clicked item from Table View
	
	/* API call */
	NSString *initialUrl = @"http://localhost/rob_api.php?company_id=";
	initialUrl=[initialUrl stringByAppendingFormat:@"%@ ",PassId];//ClickValue];//add id onto end of url looking up, not search term
	NSURL *url = [NSURL URLWithString:initialUrl]; //set NSURL
	NSError *theNetworkError; //set NSError 
	NSString *content = [NSString stringWithContentsOfURL:url encoding:NSASCIIStringEncoding error:&theNetworkError]; //query url
	
	/* decode JSON content..can put into for loop */
	NSString *jsonString = [NSString stringWithString:content]; 
	NSLog(@" %@ ",jsonString);
	NSDictionary *dictionary = [jsonString JSONValue];
	//SORT DICTIONARY ARRAY BY KEYS....so does in order
	NSArray *sortedKeys = [[dictionary allKeys] sortedArrayUsingSelector: @selector(compare:)];
	//create array to keep items in
	NSMutableArray *listOfItems = [NSMutableArray array];
	//OR listOfItems = [[NSMutableArray alloc] init]; //old
	
	/* set returned results inside array for app */
	//array of companies details
	for(NSString *key in sortedKeys) {
		id value = [dictionary objectForKey:key]; //each value
		[listOfItems addObject:value]; //put all items from json into arra, in order
	}
	
	//assigning details into view...in order returned in json string
	NSString *distance = [listOfItems objectAtIndex:0]; 
	NSString *location = [listOfItems objectAtIndex:1]; 
	NSString *clubId = [listOfItems objectAtIndex:2];
	NSString *mobile = [listOfItems objectAtIndex:3];
	NSString *website = [listOfItems objectAtIndex:4];
	NSString *address = [listOfItems objectAtIndex:5];
	NSString *sports = [listOfItems objectAtIndex:6]; 
	NSString *postcode = [listOfItems objectAtIndex:7];
	self.postcode = postcode;
	
	detailsDist.text = distance;
	detailsLoc.text = location;
	detailsSite.text = website;
	detailsAddress.text = address;
	detailsSports.text = sports;
	detailsPhone.text = mobile;
	
	//contact details...tel/website
	//venue details..address
	//sports...sport

}

- (UITableViewCellAccessoryType)tableView:(UITableView *)tv accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewCellAccessoryDetailDisclosureButton;
}


//when click button..assigned this on IB to button
-(IBAction)switchPage:(id)sender
{
	//open google maps search for that location
	//needs to pass postcode of place here
	NSString *postcodeUrl = @"http://maps.google.com/maps?q=";
	postcodeUrl=[postcodeUrl stringByAppendingFormat:@"%@",postcode];
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString: postcodeUrl]];
}

-(IBAction)switchPageTwo:(id)sender
{
	//open google maps search for that location
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.sportsbase.co.uk/sign-up"]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
}


/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

@end
