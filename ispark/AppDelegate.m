//
//  AppDelegate.m
//  ispark
//
//  Created by Natanel Partouche on 15/02/12.
//  Copyright (c) 2012 ECE. All rights reserved.
//

#import "AppDelegate.h"

#import "Liste_Park.h"
#import "Liste_Reservation.h"
#import "ParkingMap.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
        
    NSLog(@"Enter");
    
    
    Liste_Park *list=[[Liste_Park alloc]init];
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:list];
    list.title=@"Parkings";
    Liste_Reservation *listres=[[Liste_Reservation alloc]init];
    UINavigationController *navres=[[UINavigationController alloc]initWithRootViewController:listres ];

    ParkingMap *carte=[[ParkingMap alloc]initWithNibName:@"ParkingMap" bundle:nil];
    UINavigationController *navcarte=[[UINavigationController alloc]initWithRootViewController:carte ];
    UITabBarController *tab=[[UITabBarController alloc]init];
    tab.viewControllers=[NSArray arrayWithObjects:nav,navres,navcarte, nil];
    [self.window addSubview:tab.view];
       
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
