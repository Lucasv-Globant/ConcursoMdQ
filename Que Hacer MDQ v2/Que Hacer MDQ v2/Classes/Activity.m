//
//  Activity.m
//  Que Hacer MDQ v2
//
//  Created by Lucas on 3/17/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import "Activity.h"
#import "Schedule.h"
#import "Tag.h"


@implementation Activity

@dynamic cost;
@dynamic costString;
@dynamic desc;
@dynamic end;
@dynamic handicapAccessRamp;
@dynamic handicapRestroom;
@dynamic id;
@dynamic name;
@dynamic paidParkingZone;
@dynamic sharingUrl;
@dynamic start;
@dynamic visible;
@dynamic website;
@dynamic contactPhone1;
@dynamic contactPhone2;
@dynamic contactPhone3;
@dynamic costNumber;
@dynamic handicapRestroomInGroundFloor;
@dynamic locationDetails;
@dynamic locationHouseNumberingOrKm;
@dynamic locationStreetOrRoute;
@dynamic ocurrsOnce;
@dynamic photoUrl1;
@dynamic photoUrl2;
@dynamic photoUrl3;
@dynamic sourceWebServiceName;
@dynamic visitingHoursString;
@dynamic locationLatitude;
@dynamic locationLongitude;
@dynamic areaId;
@dynamic schedules;
@dynamic tags;

-(Activity*)instanceFromDictionary:(NSDictionary*)aDictionary
{
    NSManagedObjectContext* context = [[CoreDataHelper sharedInstance] managedObjectContext];
    Activity* newActivity = [NSEntityDescription insertNewObjectForEntityForName:@"Activity" inManagedObjectContext:context];

    newActivity.id = [aDictionary objectForKey:@"activityId"];
    newActivity.name = [aDictionary objectForKey:@"name"];
    newActivity.desc = [aDictionary objectForKey:@"description"];
    newActivity.contactPhone1 = [aDictionary objectForKey:@"contactPhone1"];
    newActivity.contactPhone2 = [aDictionary objectForKey:@"contactPhone2"];
    newActivity.contactPhone3 = [aDictionary objectForKey:@"contactPhone3"];
    newActivity.photoUrl1 = [aDictionary objectForKey:@"photoUrl1"];
    newActivity.photoUrl2 = [aDictionary objectForKey:@"photoUrl2"];
    newActivity.photoUrl3 = [aDictionary objectForKey:@"photoUrl3"];
    newActivity.locationStreetOrRoute = [aDictionary objectForKey:@"locationStreetOrRoute"];
    newActivity.locationHouseNumberingOrKm = [aDictionary objectForKey:@"locationHouseNumberingOrKm"];
    newActivity.locationDetails = [aDictionary objectForKey:@"locationDetails"];
    newActivity.locationLatitude = [aDictionary objectForKey:@"locationLatitude"];
    newActivity.locationLongitude = [aDictionary objectForKey:@"locationLongitude"];
    newActivity.website = [aDictionary objectForKey:@"website"];
    newActivity.visitingHoursString = [aDictionary objectForKey:@"visitingHoursString"];
    newActivity.start = [aDictionary objectForKey:@"start"];
    newActivity.end = [aDictionary objectForKey:@"end"];
    newActivity.cost = [aDictionary objectForKey:@"cost"];
    newActivity.costString = [aDictionary objectForKey:@"costString"];
    newActivity.handicapAccessRamp = [aDictionary objectForKey:@"handicapAccessRamp"];
    newActivity.handicapRestroom = [aDictionary objectForKey:@"handicapRestroom"];
    newActivity.handicapRestroomInGroundFloor = [aDictionary objectForKey:@"handicapRestroomInGroundFloor"];
    newActivity.paidParkingZone = [aDictionary objectForKey:@"paidParkingZone"];
    newActivity.sharingUrl = [aDictionary objectForKey:@"sharingUrl"];
    

    //Relationship: Tags
    NSArray* tagsSource = [aDictionary objectForKey:@"tags"];
    NSMutableArray* tagsArray = [[NSMutableArray alloc] init];
    for ( NSDictionary* tagDictionary in tagsSource) {
        [tagsArray addObject:[[CoreDataHelper sharedInstance] getTagWithId:[tagDictionary objectForKey:@"id"]]];
    }
    newActivity.tags = [[NSSet alloc] initWithArray:tagsArray];
    
    
    //Relationship: Schedules
    NSArray* schedulesSource = [aDictionary objectForKey:@"schedules"];
    NSMutableArray* schedulesArray = [[NSMutableArray alloc] init];
    for (NSDictionary* scheduleDictionary in schedulesSource)
    {
        
        [schedulesArray addObject:[[NSEntityDescription insertNewObjectForEntityForName:@"Schedule" inManagedObjectContext:context] initWithDictionary:scheduleDictionary]];
        
    }
    
    return newActivity;
}


@end
