//
//  RootViewController.h
//  NavApp
//
//  Created by Wess Cope on 3/23/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//


/* NAVIGATION-BASED APP (began sun 13th nov)
 
rootView just a loading page....so firstView and secondView are equal views....then both point to further views

4 UIViewController's created....(and main RootViewController/NavAppAppDelegate)
firstViewController -> TableViewController->ViewTwoController
SecondViewController -> TableViewController->ViewTwoController

firts/secondViewController have TABS added to each, removed animate so cant see its 2 different tabs, looks like same tab.
-it naviages between firstView (from second) and secondView (from first).
 
rootViewController forward to firstView...could equally point to secondView.
*/


#import <UIKit/UIKit.h>
#import "FirstViewController.h"


@interface RootViewController : UIViewController {
	FirstViewController *firstViewController;	
}

@property (nonatomic, retain) FirstViewController *firstViewController;

-(IBAction)switchPage:(id)sender;
-(void)loadApp;
@end
