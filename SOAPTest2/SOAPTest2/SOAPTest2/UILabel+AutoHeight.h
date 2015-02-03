//
//  UILabel+AutoHeight.h
//  TabBarExampleApp
//
//  Created by Ezequiel on 2/2/15.
//  Copyright (c) 2015 Ezequiel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UILabel (AutoHeight)

- (void) adjustHeightForWidth: (NSUInteger) width withText: (NSString*) text;

- (void) adjustHeightForWidth: (NSUInteger) width;

@end
