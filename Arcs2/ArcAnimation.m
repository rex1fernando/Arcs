//
//  ArcAnimation.m
//  Arcs
//
//  Created by Margie Fernando on 8/13/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "ArcAnimation.h"
#include <math.h>

@implementation ArcAnimation

- (id)initWithX:(int)tx Y:(int)ty R:(int)tr Offset:(int)toffset Length:(int)tlength Weight:(int)tweight
color:(NSColor*)tcolor{
    self = [super init];
    if (self) {
        x=tx;y=ty;r=tr;offset=toffset;length=tlength;weight=tweight;color=tcolor;
    }
    return self;
}

- (void)update:(double)seconds {
    double secsWithOffset = seconds + offset;
    double rate = 360.0/(2*pi*r)*700;
    
    double start = fmodf(secsWithOffset*rate, 360.0);
    double  end  = start + length;
    
    NSBezierPath*   arcPath = [NSBezierPath bezierPath];
    [arcPath appendBezierPathWithArcWithCenter:NSMakePoint(x,y) radius:r startAngle:start endAngle:end];
    [arcPath setLineWidth:weight];
    [color set];
    [arcPath stroke];
}


@end
