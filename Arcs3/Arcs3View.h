//
//  ArcsView.h
//  Arcs
//
//  Created by Margie Fernando on 8/13/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <ScreenSaver/ScreenSaver.h>
#import "ArcAnimation.h"

@interface Arcs3View : ScreenSaverView {
    NSDate *startDate;
    NSMutableArray *a;
    
    IBOutlet id sheet;
    IBOutlet id fgColorWell;
    IBOutlet id bgColorWell;
    
    NSColor *fgColor;
    NSColor *bgColor;
}

- (IBAction)updatePrefs:(id)sender;
@end
