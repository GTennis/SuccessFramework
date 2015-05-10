//
//  GMLanguage.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 6/14/13.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "GMLanguage.h"

@implementation GMLanguage

@synthesize shortName=_shortName;
@synthesize longName=_longName;

- (id)initWithShortName:(NSString *)shortName withLongName:(NSString *)longName
{
    self = [super init];
    if (self) {
        self.shortName  = shortName;
        self.longName   = longName;
    }
    return self;
}

- (void)dealloc
{
    self.shortName  = nil;
    self.longName   = nil;
}


@end
