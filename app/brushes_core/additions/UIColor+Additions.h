//
//  UIColor+Additions.h
//  Test
//
//  Created by Steve Sprang on 3/18/08.
//  Copyright 2008 Steve Sprang. All rights reserved.
//

#import "WDUtilities.h"

@interface WDUIColor (WDAdditions)

+ (WDUIColor *) randomColor:(BOOL)includeAlpha;

- (void) getHue:(float *)hue saturation:(float *)saturation brightness:(float *)brightness;

- (float) hue;
- (float) saturation;
- (float) brightness;

- (float) red;
- (float) green;
- (float) blue;

- (float) alpha;

- (void) openGLSet;
+ (WDUIColor *) saturatedRandomColor;

@end
