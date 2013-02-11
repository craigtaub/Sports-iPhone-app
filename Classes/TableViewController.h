//
//  TableViewController.h
//  SportsBase
//
//  Created by Craig Taub on 13/11/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

//displays same results for sport or club search...so uses same tableView and ViewTwo (data view).
//just api call which is diff for each, return format is same...data is different (obv)

@interface TableViewController : UITableViewController {
	NSString *PassText;
	NSString *searchType;
	NSString *sportId;
	NSString *PassId;
	NSMutableArray *listOfItems;
	NSMutableArray *listOfItemsTwo;
	NSMutableArray *listOfItemsThree;
	NSMutableArray *listOfItemsFour;
}

@property (nonatomic, retain) NSString *PassText;
@property (nonatomic, retain) NSString *searchType;
@property (nonatomic, retain) NSString *sportId;
@property (nonatomic, retain) NSString *PassId;
@property (nonatomic, retain) NSMutableArray *listOfItems;
@property (nonatomic, retain) NSMutableArray *listOfItemsTwo;
@property (nonatomic, retain) NSMutableArray *listOfItemsThree;
@property (nonatomic, retain) NSMutableArray *listOfItemsFour;

@end
