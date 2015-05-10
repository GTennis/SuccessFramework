//
//  PSCustomViewFromXib.h
//  CustomView
//
//  Created by Paul Solt on 4/28/14.
//  Copyright (c) 2014 Paul Solt. All rights reserved.
//
//  Modified by Gytenis Mikulėnas:
//  1. Renamed class name and file, changed property type
//  2. Added support for universal apps (conditional subclass autopicking)
//  3. Commented out initWithCoder method
//  4. Added self = _customView;

#import "BasePartialView.h"

@implementation BasePartialView

+ (id)alloc {
    
    NSString *viewClassName = NSStringFromClass([self class]);
    
    if ([viewClassName rangeOfString:@"ipad"].location == NSNotFound && [viewClassName rangeOfString:@"iphone"].location == NSNotFound) {
        
        if (isIpad) {
            
            viewClassName = [NSString stringWithFormat:@"%@_ipad", viewClassName];
            
        } else {
            
            viewClassName = [NSString stringWithFormat:@"%@_iphone", viewClassName];
        }
        
        return [NSClassFromString(viewClassName) alloc];
        
    } else {
        
        return [super alloc];
    }
}

// Overriding default initialization flow for partial views. They all be loaded from xib but their creation API will remain as simple as the creation of UIAlertView (alloc + init)
- (id)initWithFrame:(CGRect)frame {
    
    //self = [super initWithFrame:frame];
    //if (self) {
        // 1. Load the .xib file .xib file must match classname
        NSString *className = NSStringFromClass([self class]);
        
        BasePartialView *customView = [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] firstObject];
        
        // 2. Set the bounds if not set by programmer (i.e. init called)
        if(CGRectIsEmpty(frame)) {
            self.bounds = customView.bounds;
        }
        
        // 3. Add as a subview
        //[self addSubview:_customView];
        
        // 4. Reassign. lodNibNamed will load new instance from xib therefore we need this new loaded instance
        self = customView;
        
    //}
    return self;
}

/*- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    if(self) {
        
        // 1. Load .xib file
        NSString *className = NSStringFromClass([self class]);
        _customView = [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] firstObject];
        
        // 2. Add as a subview
        [self addSubview:_customView];
        
    }
    return self;
}*/

+ (CGSize)sizeForView {
    
    NSString *viewClassName = NSStringFromClass([self class]);
    CGSize viewSize = CGSizeZero;
    
    if (isIpad) {
        
        viewClassName = [NSString stringWithFormat:@"%@_ipad", viewClassName];
        viewSize = [NSClassFromString(viewClassName) sizeForView];
        
    } else {
        
        viewClassName = [NSString stringWithFormat:@"%@_iphone", viewClassName];
        viewSize= [NSClassFromString(viewClassName) sizeForView];
    }
    
    return viewSize;
}

@end
