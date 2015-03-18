//
//  CoreDataHelper.h
//  Que Hacer MDQ v2
//
//  Created by Lucas on 3/12/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Tag.h"
#import "Activity.h"

@interface CoreDataHelper : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL*)applicationDocumentsDirectory;
- (id)insertManagedObjectOfClass:(Class)aClass inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;
- (NSArray*)fetchEntitiesForClass:(Class)aClass withPredicate:(NSPredicate*)predicate inManagedObjectContext:(NSManagedObjectContext*)managedObjectContext;
+ (instancetype) sharedInstance;
-(NSArray*)getTagWithId:(NSNumber*)tagId;
@end
