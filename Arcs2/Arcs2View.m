//
//  ArcsView.m
//  Arcs
//
//  Created by Margie Fernando on 8/13/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "Arcs2View.h"
#include <stdlib.h>

@implementation Arcs2View
static NSString * const MyModuleName = @"rex.Arcs2";




- (id)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    
    // do work...
    
    // Find elapsed time and convert to milliseconds
    // Use (-) modifier to conversion since receiver is earlier than now
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        startDate = [NSDate date];
        
        ScreenSaverDefaults *defaults;
        
        defaults = [ScreenSaverDefaults defaultsForModuleWithName:MyModuleName];
        
        // Register our default values
        [defaults registerDefaults:[NSDictionary dictionaryWithObjectsAndKeys:
                                    [NSArchiver archivedDataWithRootObject:[NSColor blackColor]], @"fgColor",
                                    [NSArchiver archivedDataWithRootObject:[NSColor whiteColor]], @"bgColor",
                                    nil]];
        
        fgColor = [NSUnarchiver unarchiveObjectWithData:[defaults objectForKey:@"fgColor"]];
        bgColor = [NSUnarchiver unarchiveObjectWithData:[defaults objectForKey:@"bgColor"]];

        
        
        [self setAnimationTimeInterval:1/40.0];
    }
    return self;
}

int rr(int s, int e) {
    return s + arc4random() % (e+1-s);
}

- (void)startAnimation
{
    int w = [self bounds].size.width;
    int h = [self bounds].size.height;
    int mx = w/2.0;
    int my = h/2.0;
    
    
    [super startAnimation];
    [NSBezierPath setDefaultLineCapStyle:NSRoundLineCapStyle];
    a = [NSMutableArray array];
    for (int i = 0; i < 150; i++) {
        int r = i % 4 == 0 ? rr(w,2*w) : rr(75, w);
        int t = rr(0,2*pi);
        int x = r*cos(t)+rr(-25,25);
        int y = r*sin(t)+rr(-25,25);
        int length = i % 4 == 0 ? 180*500/r : rr(0,90);
        
        [a addObject: [[ArcAnimation alloc] initWithX:mx-x Y:my-y R:r Offset:rr(0,360) Length:length Weight:r/1000.0*5.0
               color:fgColor]];
    }
    
}


- (void)stopAnimation
{
    [super stopAnimation];
}

- (void)drawRect:(NSRect)rect
{
    double time = [startDate timeIntervalSinceNow] * -1.0;
    
    [super drawRect:rect];
    [bgColor set];
    NSRectFill([self bounds]);
    //    NSBezierPath*   arcPath = [NSBezierPath bezierPath];
    //    [arcPath appendBezierPathWithArcWithCenter:NSMakePoint(200,200) radius:100 startAngle:45 endAngle:90];
    //    [[NSColor blackColor] set];
    //
    //    [arcPath stroke];
    
    for (ArcAnimation *aa in a) {
        [aa update:time];
    }
    
    
    
}

- (void)animateOneFrame
{
    [self setNeedsDisplay:YES];
}

- (BOOL)hasConfigureSheet
{
    return YES;
}

- (NSWindow*)configureSheet
{
    
    ScreenSaverDefaults *defaults = [ScreenSaverDefaults defaultsForModuleWithName:MyModuleName];

    
    if (!sheet)
    {
        if (![NSBundle loadNibNamed:@"ConfigSheet" owner:self])
        {
            NSLog( @"Failed to load configure sheet." );
            NSBeep();
        }
    }
    
    [fgColorWell setColor:[NSUnarchiver unarchiveObjectWithData:[defaults objectForKey:@"fgColor"]]];
    [bgColorWell setColor:[NSUnarchiver unarchiveObjectWithData:[defaults objectForKey:@"bgColor"]]];

    
    return sheet;
}

- (IBAction)updatePrefs:(id)sender {
    [NSApp endSheet:sheet];

    ScreenSaverDefaults *defaults;
    
    defaults = [ScreenSaverDefaults defaultsForModuleWithName:MyModuleName];
    
    // Update our defaults
    [defaults setObject:[NSArchiver archivedDataWithRootObject:[fgColorWell color]] forKey:@"fgColor"];
    [defaults setObject:[NSArchiver archivedDataWithRootObject:[bgColorWell color]] forKey:@"bgColor"];


    
    // Save the settings to disk
    [defaults synchronize];
    fgColor = [fgColorWell color];
    bgColor = [bgColorWell color];

    
    
}

@end
