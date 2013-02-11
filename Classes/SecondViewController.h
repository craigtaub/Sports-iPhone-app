//
//  SecondViewController.h
//  SportsBase
//
//  Created by Craig Taub on 17/11/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

@class FirstViewController; 
//issues having first -> second and second -> first...
//so second forward declaration first with @class..NO import..cant have cycle declerations..


#import <UIKit/UIKit.h>
#import "TableViewController.h"

//SecondViewController -> when click tab for search by sport
@interface SecondViewController : UIViewController {
	TableViewController *tableViewController;
	FirstViewController *firstViewController;
	IBOutlet UITabBarItem *tabOne;
	IBOutlet UITabBarItem *tabTwo;
	IBOutlet UITabBar *myTab;
	IBOutlet UITextField *searchWord; 
	
	IBOutlet UIPickerView *pickerView; 
	//to get UIPickerView to work...in XIB...for UIPickerView->connections->outlets->dataSource/delegate => point to FileOwner
	NSMutableArray *arraySports;
	NSMutableArray *arraySportsIds;

	NSString *PassText;
	NSString *PassId;
	NSString *searchType;
	NSString *selectedSportId;
}

@property (nonatomic, retain) FirstViewController *firstViewController;
@property (nonatomic, retain) TableViewController *tableViewController;
@property (nonatomic, retain) IBOutlet UITabBarItem *tabOne;
@property (nonatomic, retain) IBOutlet UITabBarItem *tabTwo;
@property (nonatomic, retain) IBOutlet UITabBar *myTab;
@property (nonatomic, retain) IBOutlet UITextField *searchWord; 

@property (nonatomic, retain) NSString *PassText;
@property (nonatomic, retain) NSString *PassId;
@property (nonatomic, retain) NSString *searchType;
@property (nonatomic, retain) NSString *selectedSportId;

-(IBAction)switchPage:(id)sender;

-(void)pressItem2:(UITabBarItem *) item1;

@end
