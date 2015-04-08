//
//  AppDelegate.m
//  Que Hacer MDQ v2
//
//  Created by Lucas on 3/2/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import "AppDelegate.h"
#import "WSMDQActivities.h"
#import "Synchronizer.h"


@interface AppDelegate ()

@property (nonatomic, strong) PIMainMenuController *mainMenuController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSLog(@"PATH TO DATA FOLDER: %@",[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]);


    // Override point for customization after application launch.
    self.window=[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    SplashViewController* viewObj= [[SplashViewController alloc] initWithNibName:@"SplashViewController" bundle:nil];
//    UINavigationController* navigationController=[[UINavigationController alloc] initWithRootViewController:viewObj];
//    self.window.rootViewController = navigationController;
//    [self.window makeKeyAndVisible];
    
    self.sideBar = [self createSideBarStruct];
    self.window.rootViewController = self.sideBar;
    return YES;
}

- (MMDrawerController *)createSideBarStruct
{
    if (!self.mainController) {
        self.mainController = [SplashViewController new];
    }
    
    if (!self.mainMenuController) {
        self.mainMenuController = [PIMainMenuController new];
    }
    
    if (!self.centerNavigation) {
        self.centerNavigation = [[UINavigationController alloc] initWithRootViewController:self.mainController];
    }
    
    self.mainController.isAccessibilityElement = YES;
    self.mainMenuController.isAccessibilityElement = YES;
    
    MMDrawerController *sideBarContainer = [[MMDrawerController alloc] initWithCenterViewController:self.centerNavigation leftDrawerViewController:self.mainMenuController];
    
    sideBarContainer.isAccessibilityElement = YES;
    
    return sideBarContainer;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [[CoreDataHelper sharedInstance] saveContext];
}


@end
