//
//  DataAccessHelper.m
//
//  Created by Federico Gonzalez on 12/3/14.
//  Copyright (c) 2015 Federico Gonzalez. All rights reserved.
//

#import "DataAccessHelper.h"

@implementation DataAccessHelper

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;



- (NSManagedObjectContext *) managedObjectContext {
    
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"QueHacer.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

//------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------

#pragma mark Insert into context
-(id)insertManagedObjectOfClass:(Class)aClass
{
    NSManagedObject *managedObject = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(aClass) inManagedObjectContext:_managedObjectContext];
    return managedObject;
}


//------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------

#pragma mark Fetch Entities
-(NSArray*)fetchEntitiesForClass:(Class)aClass withPredicate:(NSPredicate*)predicate
{
    NSError* error;
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription* entityDescription = [NSEntityDescription entityForName:NSStringFromClass(aClass) inManagedObjectContext:_managedObjectContext];
    [fetchRequest setEntity:entityDescription];
    [fetchRequest setPredicate:predicate];
    NSArray* items = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (error)
    {
        NSLog(@"%@",[error localizedDescription]);
        return nil;
    }
    return items;
    
}





#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

//------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------

#pragma mark Singleton Methods

+ (instancetype) sharedInstance {
    
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    
    return _sharedObject;
}




//------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------


+ (BOOL) saveContext {
    
    NSManagedObjectContext *context = [[DataAccessHelper sharedInstance] managedObjectContext];
    
    NSError *localerror;
    if (![context save:&localerror]) //Guardamos los cambios en el contexto.
    {
        //Hubo error
        NSLog([NSString stringWithFormat:@"Error in saveContext, couldn't save: %@", [localerror localizedDescription]]);
        [context rollback];        
        return false;
    }
    
    
    return true;
    
}





@end
