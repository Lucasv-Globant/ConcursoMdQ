//
//  UILabel+AutoHeight.m
//  TabBarExampleApp
//
//  Created by Ezequiel on 2/2/15.
//  Copyright (c) 2015 Ezequiel. All rights reserved.
//

#import "UILabel+AutoHeight.h"

@implementation UILabel (AutoHeight)

- (void) adjustHeightForWidth:(NSUInteger)width
{
    [self adjustHeightForWidth:width withText:self.text];
}

- (void) adjustHeightForWidth: (NSUInteger) width withText: (NSString*) text
{
    const CGSize maxSize = CGSizeMake(self.frame.size.width, 9999);
    CGRect bounds = [text boundingRectWithSize: maxSize options: NSStringDrawingUsesLineFragmentOrigin attributes: @{NSFontAttributeName: self.font} context: nil];
    bounds.origin = self.frame.origin;
    self.frame = bounds;
}

@end
