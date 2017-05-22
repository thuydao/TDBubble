//
//  TDBubbleManager.m
//  Pods
//
//  Created by Tun on 5/22/17.
//
//

#import "TDBubbleManager.h"
#import "UIImage+TDOverlay.h"

@implementation TDBubbleManager

#pragma mark - Setter/Getter

- (CGFloat)maxHeight
{
    if (!_maxHeight)
    {
        if (_ibMaxHeight) return _ibMaxHeight;
        return 300;
    }
    
    return _maxHeight;
}


- (float)randomFloatBetween:(float)smallNumber and:(float)bigNumber {
    float diff = bigNumber - smallNumber;
    return (((float) (arc4random() % ((unsigned)RAND_MAX + 1)) / RAND_MAX) * diff) + smallNumber;
}

+(NSBundle *)getResourcesBundle
{
    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle bundleForClass:[self class]] URLForResource:@"TDBubble" withExtension:@"bundle"]];
    return bundle;
}


+(UIImage *)loadImageFromResourceBundle:(NSString *)imageName
{
    NSBundle *bundle = [TDBubbleManager getResourcesBundle];
    NSString *imageFileName = [NSString stringWithFormat:@"%@.png",imageName];
    UIImage *image = [UIImage imageNamed:imageFileName inBundle:bundle compatibleWithTraitCollection:nil];
    return image;
}

- (void)createBubbleWithColor:(UIColor *)color
{
    UIImage *img = [TDBubbleManager loadImageFromResourceBundle:@"heart"];
    
    UIImageView *bubbleImageView = [[UIImageView alloc] initWithImage:[img filledImageColor:color]];
    
    
    CGFloat size = [self randomFloatBetween:5 and:50];
    
    bubbleImageView.frame = CGRectMake(self.centerView.center.x, self.centerView.center.y, size, size);
    
    bubbleImageView.alpha = [self randomFloatBetween:.1 and:1];
    
    [self.parentView addSubview:bubbleImageView];
    
    UIBezierPath *zigzagPath = [[UIBezierPath alloc] init];
    CGFloat oX = bubbleImageView.frame.origin.x;
    CGFloat oY = bubbleImageView.frame.origin.y;
    CGFloat eX = oX;
    CGFloat eY = oY - [self randomFloatBetween:50 and:[self maxHeight]];
    CGFloat t = [self randomFloatBetween:20 and:100];
    CGPoint cp1 = CGPointMake(oX - t, ((oY + eY) / 2));
    CGPoint cp2 = CGPointMake(oX + t, cp1.y);
    
    // randomly switch up the control points so that the bubble
    // swings right or left at random
    NSInteger r = arc4random() % 2;
    if (r == 1) {
        CGPoint temp = cp1;
        cp1 = cp2;
        cp2 = temp;
    }
    
    // the moveToPoint method sets the starting point of the line
    [zigzagPath moveToPoint:CGPointMake(oX, oY)];
    // add the end point and the control points
    [zigzagPath addCurveToPoint:CGPointMake(eX, eY) controlPoint1:cp1 controlPoint2:cp2];
    
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        // transform the image to be 1.3 sizes larger to
        // give the impression that it is popping
        [UIView transitionWithView:bubbleImageView
                          duration:0.1f
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
                            bubbleImageView.transform = CGAffineTransformMakeScale(1.3, 1.3);
                        } completion:^(BOOL finished) {
                            [bubbleImageView removeFromSuperview];
                        }];
    }];
    
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.duration = 2;
    pathAnimation.path = zigzagPath.CGPath;
    // remains visible in it's final state when animation is finished
    // in conjunction with removedOnCompletion
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    
    [bubbleImageView.layer addAnimation:pathAnimation forKey:@"movingAnimation"];
    
    [CATransaction commit];
    
}


@end
