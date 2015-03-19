//
//  Activity.h
//  Que Hacer MDQ v2
//
//  Created by Lucas on 3/19/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "CoreDataHelper.h"

@class Schedule, Tag;

@interface Activity : NSManagedObject

@property (nonatomic, retain) NSNumber * cost;
@property (nonatomic, retain) NSString * costString;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSDate * end;
@property (nonatomic, retain) NSNumber * handicapAccessRamp;
@property (nonatomic, retain) NSNumber * handicapRestroom;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * paidParkingZone;
@property (nonatomic, retain) NSString * sharingUrl;
@property (nonatomic, retain) NSDate * start;
@property (nonatomic, retain) NSNumber * visible;
@property (nonatomic, retain) NSString * website;
@property (nonatomic, retain) NSString * contactPhone1;
@property (nonatomic, retain) NSString * contactPhone2;
@property (nonatomic, retain) NSString * contactPhone3;
@property (nonatomic, retain) NSNumber * costNumber;
@property (nonatomic, retain) NSNumber * handicapRestroomInGroundFloor;
@property (nonatomic, retain) NSString * locationDetails;
@property (nonatomic, retain) NSString * locationHouseNumberingOrKm;
@property (nonatomic, retain) NSString * locationStreetOrRoute;
@property (nonatomic, retain) NSString * ocurrsOnce;
@property (nonatomic, retain) NSString * photoUrl1;
@property (nonatomic, retain) NSString * photoUrl2;
@property (nonatomic, retain) NSString * photoUrl3;
@property (nonatomic, retain) NSString * sourceWebServiceName;
@property (nonatomic, retain) NSString * visitingHoursString;
@property (nonatomic, retain) NSNumber * locationLatitude;
@property (nonatomic, retain) NSNumber * locationLongitude;
@property (nonatomic, retain) NSNumber * areaId;
@property (nonatomic, retain) NSSet *schedules;
@property (nonatomic, retain) NSSet *tags;
@end

@interface Activity (CoreDataGeneratedAccessors)

- (void)addSchedulesObject:(Schedule *)value;
- (void)removeSchedulesObject:(Schedule *)value;
- (void)addSchedules:(NSSet *)values;
- (void)removeSchedules:(NSSet *)values;

- (void)addTagsObject:(Tag *)value;
- (void)removeTagsObject:(Tag *)value;
- (void)addTags:(NSSet *)values;
- (void)removeTags:(NSSet *)values;
+(Activity*)persistentInstanceFromDictionary:(NSDictionary*)aDictionary;
@end
