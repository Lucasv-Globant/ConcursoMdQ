//
//  Synchronizer.m
//  Que Hacer MDQ v2
//
//  Created by Lucas on 3/19/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//
//  This class retrieves the data via the web service helper and saves it into core data.
//


#import "Synchronizer.h"

@implementation Synchronizer

-(void)syncWithSuccess:(SyncSuccess)successBlock
                failure:(SyncFailure)failureBlock
{

    __weak Synchronizer* weakself = self;
    WSMDQActivities* ws = [[WSMDQActivities alloc] init];
    self.webserviceInstance = ws;
    [ws getTagsWithSuccess:^(NSMutableArray* json)
                            {
                                self.tagsJSON = json;
                                //Tags were captured, now we should continue with an attempt to download the activities
                                [ws getActivitiesWithSuccess:^(NSMutableArray* activitiesjson)
                                                            {
                                                                self.activitiesJSON = activitiesjson;
                                                                [self importIntoCoreDataWithSuccess:successBlock];
                                                            }
                                                     failure:^(NSError* error)
                                                            {
                                                                failureBlock(error);
                                                            }
                                 
                                     withFilteringParameters:@{}];
                                //If the download of activities goes well, we should proceed with converting the tags from JSON to model objects in core data
                                //Once the tags are persisted, do the same with the Activities.
                            }
                   failure:^(NSError* error)
                            {
                                failureBlock(error);
                            }
     ];
}


-(void)importIntoCoreDataWithSuccess:(SyncSuccess)successBlock
{
    NSLog(@"Core Data Import begins...");
    //Grab shared instance of CoreDataHelper
    CoreDataHelper* cdh = [CoreDataHelper sharedInstance];
    
    //Purging the cache
    [cdh deleteAllTags];
    [cdh deleteAllActivities];
    
    //Creating a temporary mutable array to store the Tag class objects
    NSMutableArray* tagObjectsMutableArray = [[NSMutableArray alloc] init];
    for (NSDictionary* tagJSON in self.tagsJSON)
    {
        //Converting from NSDictionary to Tag object (with persistence)
        [tagObjectsMutableArray addObject:[Tag persistentInstanceFromDictionary:tagJSON]];
    }
    
    //Save the temporary mutable array of Tags as a immutable array
    self.tagObjects = [[NSArray alloc] initWithArray:tagObjectsMutableArray];
    
    //Creating a temporary mutable array to store the Activity class objects
    NSMutableArray* activityObjectsMutableArray = [[NSMutableArray alloc] init];
    for (NSDictionary* activityJSON in self.activitiesJSON)
    {
        //Converting from NSDictionary to Activity object (with persistence)
        [activityObjectsMutableArray addObject:[Activity persistentInstanceFromDictionary:activityJSON]];
    }
    
    //Save the temporary mutable array of Activities as a immutable array
    self.activityObjects = [[NSArray alloc] initWithArray:activityObjectsMutableArray];
    
    //Finally, execute the success block that was passed as a parameter:
    successBlock(activityObjectsMutableArray);
}


@end
