//
//  ActivitiesCollection.h
//  Que Hacer MDQ v2
//
//  Created by Lucas on 5/15/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivitiesCollection : NSObject
-(ActivitiesCollection*)initWithArray:(NSArray*)arrayOfActivities;
-(NSArray*)filterActivitiesWithTagIds:(NSArray*)arrayOfNSNumbers;
@end
