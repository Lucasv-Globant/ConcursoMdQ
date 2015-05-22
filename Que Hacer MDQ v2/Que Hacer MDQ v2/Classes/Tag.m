//
//  Tag.m
//  Que Hacer MDQ v2
//
//  Created by Lucas on 3/17/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import "Tag.h"
#import "Activity.h"


@implementation Tag

@dynamic desc;
@dynamic tagId;
@dynamic name;
@dynamic activity;

+(Tag*)instanceFromDictionary:(NSDictionary*)aDictionary
{
    //TO BE COMPLETED
    return [[Tag alloc] init];
}

+(Tag*)persistentInstanceFromDictionary:(NSDictionary*)aDictionary
{
    /*
     {
     "id": "1",
     "name": "General",
     "description": "Actividades sin clasificacion"
     },
     */
    NSManagedObjectContext* context = [[CoreDataHelper sharedInstance] managedObjectContext];
    Tag* tag = [NSEntityDescription insertNewObjectForEntityForName:@"Tag" inManagedObjectContext:context];
    tag.tagId = [DataTypesHelper stringToNSNumber:[aDictionary objectForKey:@"id"]];
    
    if ([[aDictionary objectForKey:@"name"] isKindOfClass:[NSNull class]])
    {
        tag.name = @"";
    }
    else
    {
        tag.name = [aDictionary objectForKey:@"name"];
    }
    
    if ([[aDictionary objectForKey:@"description"] isKindOfClass:[NSNull class]])
    {
        tag.desc = @"";
    }
    else
    {
        tag.desc = [aDictionary objectForKey:@"description"];
    }
    
    NSError* error;
    [context save:&error];
    if (error)
    {
        NSLog(@"Something went wrong when saving the tag with id %@",tag.tagId);
        NSLog(@"The error description is : %@",error.localizedDescription);
        return nil;
    }
    return tag;
    
}


@end