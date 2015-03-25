//
//  Activity.m
//  Que Hacer MDQ v2
//
//  Created by Lucas on 3/19/15.
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


+(Activity*)persistentInstanceFromDictionary:(NSDictionary*)aDictionary
{
    NSManagedObjectContext* context = [[CoreDataHelper sharedInstance] managedObjectContext];
    Activity* newActivity = [NSEntityDescription insertNewObjectForEntityForName:@"Activity" inManagedObjectContext:context];
    
    newActivity.id = [DataTypesHelper stringToNSNumber:[aDictionary objectForKey:@"activityId"]];
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
    newActivity.locationLatitude = [DataTypesHelper stringToNSNumber:[aDictionary objectForKey:@"locationLatitude"]];
    newActivity.locationLongitude = [DataTypesHelper stringToNSNumber:[aDictionary objectForKey:@"locationLongitude"]];
    newActivity.website = [aDictionary objectForKey:@"website"];
    newActivity.visitingHoursString = [aDictionary objectForKey:@"visitingHoursString"];
    newActivity.start = [DataTypesHelper qhmdqDateTimeStringToNSDate:[aDictionary objectForKey:@"start"]];
    newActivity.end = [DataTypesHelper qhmdqDateTimeStringToNSDate:[aDictionary objectForKey:@"end"]];
    newActivity.cost = [DataTypesHelper stringToNSNumber:[aDictionary objectForKey:@"cost"]];
    newActivity.costString = [aDictionary objectForKey:@"costString"];
    newActivity.handicapAccessRamp = [DataTypesHelper stringToNSNumber:[aDictionary objectForKey:@"handicapAccessRamp"] ];
    newActivity.handicapRestroom = [DataTypesHelper stringToNSNumber:[aDictionary objectForKey:@"handicapRestroom"]];
    newActivity.handicapRestroomInGroundFloor = [DataTypesHelper stringToNSNumber:[aDictionary objectForKey:@"handicapRestroomInGroundFloor"]];
    newActivity.paidParkingZone = [DataTypesHelper stringToNSNumber:[aDictionary objectForKey:@"paidParkingZone"]];
    newActivity.sharingUrl = [aDictionary objectForKey:@"sharingUrl"];
    
    
    //Relationship: Tags
    NSArray* tagsSource = [aDictionary objectForKey:@"tags"];
    NSMutableArray* tagsArray = [[NSMutableArray alloc] init];
    for ( NSDictionary* tagDictionary in tagsSource) {
        [tagsArray addObject:[[CoreDataHelper sharedInstance] getTagWithId:[tagDictionary objectForKey:@"tagId"]]];
    }
    newActivity.tags = [[NSSet alloc] initWithArray:tagsArray];
    
    
    //Relationship: Schedules
    NSArray* schedulesSource = [aDictionary objectForKey:@"schedules"];
    NSMutableArray* schedulesArray = [[NSMutableArray alloc] init];
    for (NSDictionary* scheduleDictionary in schedulesSource)
    {
        [schedulesArray addObject:[[NSEntityDescription insertNewObjectForEntityForName:@"Schedule" inManagedObjectContext:context] initWithDictionary:scheduleDictionary]];
    }
    newActivity.schedules = [[NSSet alloc] initWithArray:schedulesArray];
    
    NSError* error;
    [context save:&error];
    if (error)
    {
        NSLog(@"There was an error when trying to save the activity with id %@", newActivity.id);
        return nil;
    }
    return newActivity;
}

-(Activity*)setFromDictionary:(NSDictionary*)aDictionary
{
    
    self.id = [DataTypesHelper stringToNSNumber:[aDictionary objectForKey:@"activityId"]];
    self.name = [aDictionary objectForKey:@"name"];
    self.desc = [aDictionary objectForKey:@"description"];
    self.contactPhone1 = [aDictionary objectForKey:@"contactPhone1"];
    self.contactPhone2 = [aDictionary objectForKey:@"contactPhone2"];
    self.contactPhone3 = [aDictionary objectForKey:@"contactPhone3"];
    self.photoUrl1 = [aDictionary objectForKey:@"photoUrl1"];
    self.photoUrl2 = [aDictionary objectForKey:@"photoUrl2"];
    self.photoUrl3 = [aDictionary objectForKey:@"photoUrl3"];
    self.locationStreetOrRoute = [aDictionary objectForKey:@"locationStreetOrRoute"];
    self.locationHouseNumberingOrKm = [aDictionary objectForKey:@"locationHouseNumberingOrKm"];
    self.locationDetails = [aDictionary objectForKey:@"locationDetails"];
    self.locationLatitude = [DataTypesHelper stringToNSNumber:[aDictionary objectForKey:@"locationLatitude"]];
    self.locationLongitude = [DataTypesHelper stringToNSNumber:[aDictionary objectForKey:@"locationLongitude"]];
    self.website = [aDictionary objectForKey:@"website"];
    self.visitingHoursString = [aDictionary objectForKey:@"visitingHoursString"];
    self.start = [DataTypesHelper qhmdqDateTimeStringToNSDate:[aDictionary objectForKey:@"start"]];
    self.end = [DataTypesHelper qhmdqDateTimeStringToNSDate:[aDictionary objectForKey:@"end"]];
    self.cost = [DataTypesHelper stringToNSNumber:[aDictionary objectForKey:@"cost"]];
    self.costString = [aDictionary objectForKey:@"costString"];
    self.handicapAccessRamp = [DataTypesHelper stringToNSNumber:[aDictionary objectForKey:@"handicapAccessRamp"] ];
    self.handicapRestroom = [DataTypesHelper stringToNSNumber:[aDictionary objectForKey:@"handicapRestroom"]];
    self.handicapRestroomInGroundFloor = [DataTypesHelper stringToNSNumber:[aDictionary objectForKey:@"handicapRestroomInGroundFloor"]];
    self.paidParkingZone = [DataTypesHelper stringToNSNumber:[aDictionary objectForKey:@"paidParkingZone"]];
    self.sharingUrl = [aDictionary objectForKey:@"sharingUrl"];
    
    
    //Relationship: Tags
    NSArray* tagsSource = [aDictionary objectForKey:@"tags"];
    NSMutableArray* tagsArray = [[NSMutableArray alloc] init];
    for ( NSDictionary* tagDictionary in tagsSource) {
        [tagsArray addObject:[Tag instanceFromDictionary:tagDictionary]];
    }
    self.tags = [[NSSet alloc] initWithArray:tagsArray];
    
    //Relationship: Schedules
    NSArray* schedulesSource = [aDictionary objectForKey:@"schedules"];
    NSMutableArray* schedulesArray = [[NSMutableArray alloc] init];
    for (NSDictionary* scheduleDictionary in schedulesSource)
    {
        [schedulesArray addObject:[Schedule instanceFromDictionary:scheduleDictionary]];
    }
    self.schedules = [[NSSet alloc] initWithArray:tagsArray];
    
    return self;
}



@end
