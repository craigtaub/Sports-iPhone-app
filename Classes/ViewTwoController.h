//
//  ViewTwoController.h
//  NavApp
//
//  Created by Wess Cope on 3/23/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

//details page for item/club
@interface ViewTwoController : UIViewController {
	NSString *PassText;
	NSString *PassId;
	NSString *ClickValue;
	NSString *postcodeUrl;
	NSString *postcode;
	IBOutlet UILabel *label;
	IBOutlet UILabel *labelTwo;
	IBOutlet UILabel *labelThree;
	IBOutlet UILabel *detailsDist;
	IBOutlet UILabel *detailsLoc;
	IBOutlet UILabel *detailsSite;
	IBOutlet UITextView *detailsAddress;
	IBOutlet UILabel *detailsSports;
	IBOutlet UILabel *detailsPhone;
	NSMutableArray *listOfItems;
	NSMutableArray *listOfItemsTwo;
	NSMutableArray *listOfItemsThree;
	NSMutableArray *listOfItemsFour;
	
}

@property (nonatomic, retain) IBOutlet UILabel *label;
@property (nonatomic, retain) IBOutlet UILabel *labelTwo;
@property (nonatomic, retain) IBOutlet UILabel *labelThree;
@property (nonatomic, retain) NSString *PassText;
@property (nonatomic, retain) NSString *PassId;
@property (nonatomic, retain) NSString *ClickValue;
@property (nonatomic, retain) NSString *postcodeUrl;
@property (nonatomic, retain) NSString *postcode;
@property (nonatomic, retain) IBOutlet UILabel *detailsDist;
@property (nonatomic, retain) IBOutlet UILabel *detailsLoc;
@property (nonatomic, retain) IBOutlet UILabel *detailsSite;
@property (nonatomic, retain) IBOutlet UITextView *detailsAddress;
@property (nonatomic, retain) IBOutlet UILabel *detailsSports;
@property (nonatomic, retain) IBOutlet UILabel *detailsPhone;
@property (nonatomic, retain) NSMutableArray *listOfItems;
@property (nonatomic, retain) NSMutableArray *listOfItemsTwo;
@property (nonatomic, retain) NSMutableArray *listOfItemsThree;

-(IBAction)switchPage:(id)sender;

-(IBAction)switchPageTwo:(id)sender;
@end
