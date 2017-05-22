//
//  TDBubbleManager.h
//  Pods
//
//  Created by Tun on 5/22/17.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIkit.h>

@interface TDBubbleManager : NSObject

@property (weak, nonatomic) IBOutlet UIView *centerView; // begin center of this view
@property (weak, nonatomic) IBOutlet UIView *parentView; //show on this view

@property (assign, nonatomic) CGFloat maxHeight; //default = 300;
@property (nonatomic) IBInspectable CGFloat ibMaxHeight;

- (void)createBubbleWithColor:(UIColor *)color;

@end
