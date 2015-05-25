//
//  GMLanguage.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulenas on 6/14/13.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GMLanguage : NSObject

@property (nonatomic, copy) NSString *shortName; // en, de
@property (nonatomic, copy) NSString *longName;  // English, Deutsch

- (id)initWithShortName:(NSString*)shortName withLongName:(NSString*)longName;

@end
