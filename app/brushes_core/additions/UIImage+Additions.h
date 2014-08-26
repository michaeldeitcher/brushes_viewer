//
//  UIImage+Additions.h
//  Brushes
//
//  Created by Steve Sprang on 7/14/08.
//  Copyright 2008 Steve Sprang. All rights reserved.
//
#import "WDUtilities.h"

@interface WDImage (WDAdditions)

+ (WDImage *) relevantImageNamed:(NSString *)imageName;

- (void) drawToFillRect:(CGRect)bounds;

- (WDImage *) rotatedImage:(int)rotation;

- (WDImage *) downsampleWithMaxDimension:(float)constraint;

- (WDImage *) JPEGify:(float)compressionFactor;

- (BOOL) hasAlpha;
- (BOOL) reallyHasAlpha;

@end
