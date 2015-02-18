//
//  DataAccessHelper.h
//
//  Created by Federico Gonzalez on 12/3/14.
//  Copyright (c) 2015 Federico Gonzalez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DataAccessHelper : NSObject

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;


+ (instancetype) sharedInstance;
+ (BOOL) saveContext;
- (NSURL *)applicationDocumentsDirectory; // nice to have to reference files for core data

@end
