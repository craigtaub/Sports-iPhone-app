//
//  NavAppAppDelegate.m
//  NavApp
//
//  Created by Wess Cope on 3/23/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "NavAppAppDelegate.h"

@implementation NavAppAppDelegate

@synthesize window;
@synthesize navigationController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
	
navigationController:willShowViewController:animated:
    // Override point for customization after application launch
	[window addSubview:[navigationController view]];
    [window makeKeyAndVisible];
}


- (void)dealloc {
	[navigationController release];
    [window release];
    [super dealloc];
}


@end
