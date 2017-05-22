#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "TDBubble.h"
#import "TDBubbleManager.h"
#import "UIImage+TDOverlay.h"

FOUNDATION_EXPORT double TDBubbleVersionNumber;
FOUNDATION_EXPORT const unsigned char TDBubbleVersionString[];

