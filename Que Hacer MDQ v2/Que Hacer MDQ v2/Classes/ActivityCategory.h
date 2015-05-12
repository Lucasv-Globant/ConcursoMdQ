//
//  ActivityCategory.h
//  Que Hacer MDQ v2
//
//  Created by Lucas on 3/27/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppSettings.h"

@interface ActivityCategory : NSObject

@property int categoryId;
@property (nonatomic,strong) NSString* name;
@property (nonatomic, strong) NSString* imageFileName;
@property (nonatomic, strong) NSString* iconFileName;
@property (nonatomic, strong) NSString* imageOriginFileName;
@property (nonatomic,strong) NSNumber* tagId;
@property BOOL isSelected;
+(NSArray*)categoriesListing;
+(NSArray*)getSelectedCategories;
+(void)saveSettingsForCategories:(NSArray*)categories;
@end
