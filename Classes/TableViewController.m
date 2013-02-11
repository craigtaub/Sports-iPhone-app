//
//  TableViewController.m
//  SportsBase
//
//  Created by Craig Taub on 13/11/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TableViewController.h"
#import "ViewTwoController.h"
#import "JSON.h" 

@implementation TableViewController

@synthesize PassText;
@synthesize searchType;
@synthesize sportId;
@synthesize PassId;

#pragma mark -
#pragma mark View lifecycle

//name of club
//distance
//location
//id of club

- (void)viewDidLoad {
	[super viewDidLoad];
	
	/* NSLog(@"%@",searchType); //works, 'club' or 'sport'
	if (sportId){
		NSLog(@"%@",sportId);	//works, prints id given
	} else {
		NSLog(@"no sport id");
	} */
	
	self.navigationItem.hidesBackButton = NO; //seems like if it hasnt shown any navigation item yet it ignores this
	self.navigationItem.title = PassText; //search string
	
	//Initialize the arrays.
	listOfItems = [[NSMutableArray alloc] init];
	listOfItemsTwo = [[NSMutableArray alloc] init];
	listOfItemsThree = [[NSMutableArray alloc] init];
	listOfItemsFour = [[NSMutableArray alloc] init];
	
	/* NSArray *itemArray = [NSArray arrayWithObjects: @"One", @"Two", @"Three",nil];
	NSString *string = [itemArray objectAtIndex: 0]; //index in file...0-> title, 1->??
	[listOfItems addObject:string]; */

	/* API call */
	NSString *initialUrl;
	if(sportId){
		//sport_id and search_sport vars (search term)
		initialUrl = @"http://localhost/rob_api.php?sport_id=";
		initialUrl=[initialUrl stringByAppendingFormat:@"%@&search_sport=",sportId];//add id onto end of url looking up
	} else {
		//just search_club var (search term)
		initialUrl = @"http://localhost/rob_api.php?search_club=";
	}
	
	
	initialUrl=[initialUrl stringByAppendingFormat:@"%@ ",PassText];//add id onto end of url looking up
	//NSLog(@"%@",initialUrl); //diff for each depending on the search
	NSURL *url = [NSURL URLWithString:initialUrl]; //set NSURL
	NSError *theNetworkError; //set NSError 
	NSString *content = [NSString stringWithContentsOfURL:url encoding:NSASCIIStringEncoding error:&theNetworkError]; //query url
	
	/* decode JSON content..can put into for loop */
	NSString *jsonString = [NSString stringWithString:content]; 
	NSDictionary *dictionary = [jsonString JSONValue];

	//if need to sort array http://howtomakeiphoneapps.com/how-to-sort-an-array-in-objective-c/42/
	
	/* set returned results inside array for app */
	//required to be an array, of JUST titles
	for(NSString *key in dictionary) {
		id value = [dictionary objectForKey:key]; //each value
		for(NSString *keyTwo in value) { //array of each items contents
			if ([keyTwo isEqualToString:@"1"]) { //key of 1 is title...
				id valueTwo = [value objectForKey:keyTwo];
				[listOfItems addObject:valueTwo];
			} 
		}
	}
	
	//required for distance vals
	for(NSString *keyThree in dictionary) {
		id valueThree = [dictionary objectForKey:keyThree]; //each value
		for(NSString *keyFour in valueThree) { //array of each items contents
			if ([keyFour isEqualToString:@"2"]) { //key of 2 is distance...
				id valueFour = [valueThree objectForKey:keyFour];
				[listOfItemsTwo addObject:valueFour];
			} 
		}
	}

	//required for location vals
	for(NSString *keyFive in dictionary) {
		id valueFive = [dictionary objectForKey:keyFive]; //each value
		for(NSString *keySix in valueFive) { //array of each items contents
			if ([keySix isEqualToString:@"3"]) { //key of 3 is location...
				id valueSix = [valueFive objectForKey:keySix];
				[listOfItemsThree addObject:valueSix];
			} 
		}
	}

	//required for id vals
	for(NSString *keySeven in dictionary) {
		id valueSeven = [dictionary objectForKey:keySeven]; //each value
		for(NSString *keyEight in valueSeven) { //array of each items contents
			if ([keyEight isEqualToString:@"4"]) { //key of 4 is id...
				id valueEight = [valueSeven objectForKey:keyEight];
				[listOfItemsFour addObject:valueEight];
			} 
		}
	}
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [listOfItems count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //if (cell == nil) { //commented out, makes slightly slower...but when scroll up n down was changing indexPath.row num so messing up bg colours
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
		//changed to UITableViewCellStyleDefault/StyleSubtitle, so can add subtitle at bottom
	//}
    
    //Configure the cell...
    //cell.textLabel.text = [NSString	 stringWithFormat:@"Cell Row %d", [indexPath row]];
	NSString *cellValue = [listOfItems objectAtIndex:indexPath.row];
	cell.text = cellValue;	

	//subtitle text
	NSString *distance = [listOfItemsTwo objectAtIndex:indexPath.row];
	NSString *location = [listOfItemsThree objectAtIndex:indexPath.row];
	NSString *locdist=[distance stringByAppendingFormat:@", %@ ",location]; //TESTING CAN SEE ROW NUM
	cell.detailTextLabel.text = locdist;//distance...county and postcode
	cell.detailTextLabel.textColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:1]; //set color
	cell.textColor = [UIColor colorWithRed:0/255.0f green:83/255.0f blue:170/255.0f alpha:1]; //set color
	
	//ISSUE if scroll hard up or down changes colours of others
	//if row multiple of 2 display diff text bg and cell bg.
	if (indexPath.row % 2 == 0){
	//if(indexPath.row == 1){ //testing
		cell.textLabel.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:1]; //set text bg
		cell.detailTextLabel.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:1]; //set detail text bg
		UIView *solidColor = [cell viewWithTag:100];//set view bg
		if (!solidColor) {
			solidColor = [[UIView alloc] initWithFrame:cell.bounds];
			solidColor.tag = 100; //Big tag to access the view afterwards
			[cell addSubview:solidColor];
			[cell sendSubviewToBack:solidColor];
			[solidColor release];
		}
		solidColor.backgroundColor = [UIColor colorWithRed:212.0/255.0 green:234.0/255.0 blue:228.0/255.0 alpha:1.0]; //important to set for view
	}
	
	
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //add arrow on right
	
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller

	//CLICK INTO DETAIL VIEW FOR ITEM
	//Initialize the detail view controller and display it.
	ViewTwoController *dvController = [[ViewTwoController alloc] initWithNibName:@"View2" bundle:[NSBundle mainBundle]];
	dvController.PassText = PassText; //ID HERE
	NSString *clubId = [listOfItemsFour objectAtIndex:indexPath.row]; //object clicked
	dvController.PassId = clubId;  //passing var from results page to details page...pass id
	
	NSString *cellValue = [listOfItems objectAtIndex:indexPath.row]; //object clicked
	dvController.ClickValue = cellValue;
	[self.navigationController pushViewController:dvController animated:YES];
	[dvController release];
	dvController = nil;
	
	
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

