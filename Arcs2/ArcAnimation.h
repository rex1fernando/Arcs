//
//  ArcAnimation.h
//  Arcs
//
//  Created by Margie Fernando on 8/13/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArcAnimation : NSObject {
    int x, y, r, offset, length, weight;
    NSColor *color;
}

- (id)initWithX:(int)tx Y:(int)ty R:(int)tr Offset:(int)toffset Length:(int)tlength Weight:(int)tweight
          color:(NSColor*) tcolor;
- (void)update:(double)seconds;

@end
