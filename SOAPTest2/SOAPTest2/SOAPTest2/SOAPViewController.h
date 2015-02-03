//
//  SOAPViewController.h
//  SOAPTest2
//
//  Created by Lucas on 1/27/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "BeachesViewController.h"


@interface SOAPViewController : UIViewController<NSXMLParserDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSXMLParser *rssParser;
@property (strong, nonatomic) NSMutableArray *articles;
@property (strong, nonatomic) NSMutableDictionary *item;
@property (strong, nonatomic) NSString *currentElement;
@property (strong, nonatomic) NSMutableString *ElementValue;
@property BOOL errorParsing;
- (void)parseXMLFileAtURL:(NSString *)URL;

@end
