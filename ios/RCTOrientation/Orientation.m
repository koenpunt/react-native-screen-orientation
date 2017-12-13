//
//  Orientation.m
//

#import "Orientation.h"
#import <React/RCTEventDispatcher.h>

@implementation Orientation

static UIInterfaceOrientationMask _orientations = UIInterfaceOrientationMaskAllButUpsideDown;

+ (BOOL)requiresMainQueueSetup
{
  return NO;
}

+ (void)setSupportedInterfaceOrientations:(UIInterfaceOrientationMask)orientations
{
  _orientations = orientations;
}

+ (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
  return _orientations;
}

- (void)setOrientation:(UIInterfaceOrientation)orientation
{
  [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInt:orientation] forKey:@"orientation"];
    [UIViewController attemptRotationToDeviceOrientation];
  }];
}

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(lockToPortrait)
{
  [Orientation setSupportedInterfaceOrientations:UIInterfaceOrientationMaskPortrait];
  [self setOrientation:UIInterfaceOrientationPortrait];
}

RCT_EXPORT_METHOD(lockToPortraitUpsideDown)
{
  [Orientation setSupportedInterfaceOrientations:UIInterfaceOrientationMaskPortraitUpsideDown];
  [self setOrientation:UIInterfaceOrientationPortraitUpsideDown];
}

RCT_EXPORT_METHOD(lockToLandscape)
{
  UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];

  [Orientation setSupportedInterfaceOrientations:UIInterfaceOrientationMaskLandscape];

  if (UIDeviceOrientationIsLandscape(orientation)) {
    if (orientation == UIDeviceOrientationLandscapeLeft) {
      [self setOrientation:UIInterfaceOrientationLandscapeLeft];
    } else {
      [self setOrientation:UIInterfaceOrientationLandscapeRight];
    }
  } else {
    [self setOrientation:UIInterfaceOrientationLandscapeLeft];
  }
}

RCT_EXPORT_METHOD(lockToLandscapeRight)
{
  [Orientation setSupportedInterfaceOrientations:UIInterfaceOrientationMaskLandscapeRight];
  [self setOrientation:UIInterfaceOrientationLandscapeRight];
}

RCT_EXPORT_METHOD(lockToLandscapeLeft)
{
  [Orientation setSupportedInterfaceOrientations:UIInterfaceOrientationMaskLandscapeLeft];
  [self setOrientation:UIInterfaceOrientationLandscapeLeft];
}

RCT_EXPORT_METHOD(unlockAll)
{
  [Orientation setSupportedInterfaceOrientations:UIInterfaceOrientationMaskAll];
}

RCT_EXPORT_METHOD(unlockAllButUpsideDown)
{
  [Orientation setSupportedInterfaceOrientations:UIInterfaceOrientationMaskAllButUpsideDown];
  if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortraitUpsideDown) {
    [self setOrientation:UIInterfaceOrientationPortrait];
  }
}

@end
