//
//  FirstViewController.h
//  SportsBase
//
//  Created by Craig Taub on 19/11/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewController.h"
#import "SecondViewController.h"

@interface FirstViewController : UIViewController {
	TableViewController *tableViewController;
	SecondViewController *secondViewController;
	IBOutlet UITextField *searchWord; 
	NSString *PassText;
	NSString *PassId;
	IBOutlet UITabBarItem *tabOne;
	IBOutlet UITabBarItem *tabTwo;
	IBOutlet UITabBar *myTab;
	NSString *searchType;
}

@property (nonatomic, retain) SecondViewController *secondViewController;
@property (nonatomic, retain) TableViewController *tableViewController;
@property (nonatomic, retain) IBOutlet UITextField *searchWord;
@property (nonatomic, retain) NSString *PassText;
@property (nonatomic, retain) NSString *PassId;
@property (nonatomic, retain) IBOutlet UITabBarItem *tabOne;
@property (nonatomic, retain) IBOutlet UITabBarItem *tabTwo;
@property (nonatomic, retain) IBOutlet UITabBar *myTab;
@property (nonatomic, retain) NSString *searchType;


-(IBAction)switchPage:(id)sender;

-(void)pressItem1:(UITabBarItem *) item1;


@end
