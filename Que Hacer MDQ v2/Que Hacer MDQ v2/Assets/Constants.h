//
//  Constants.h
//  Que Hacer? MdQ
//
//  Created by Federico Gonzalez on 2/13/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Constants : NSObject

//App Global
#define APP_VERSION @"1.0"

//Networking Constants
extern float const requestsTimeout;
extern NSString* const token;


//Concurso
extern NSString* const ConcursoWS_baseURL;
extern NSString* const ConcursoWS_Activities;

//WSMDQActivities
extern NSString* const WSMDQActivities_baseURL;
extern NSString* const WSMDQActivities_Activities;
extern NSString* const WSMDQActivities_TagsList;

//Key strings for NSUserDefaults
extern NSString* const NSUserDefaults_KeyForCategoriesSelection;
extern NSString* const NSUserDefaults_KeyForFavorites;
#define NSUserDefaults_KeyForDateOfLasSynchronization @"NSUSERDEFAULTS_LAST_SYNCHRO_DATE"

@end
