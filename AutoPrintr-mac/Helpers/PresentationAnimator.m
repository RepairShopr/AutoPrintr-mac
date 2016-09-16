//
//  AutoPrintr-mac
//
//  Copyright © 2016 MIT/RepairShopr. All rights reserved.
//

#import "PresentationAnimator.h"

@interface PresentationAnimator()
@property (nonatomic) NSSize windowSize;
@end

@implementation PresentationAnimator

+ (instancetype)createWithWindowSize:(NSSize)windowSize {
    PresentationAnimator *animator = [self new];
    
    animator.windowSize = windowSize;
    
    return animator;
}

- (void)animatePresentationOfViewController:(NSViewController *)viewController
                         fromViewController:(NSViewController *)fromViewController {
    NSViewController *bottomViewController = fromViewController;
    NSViewController *topViewController = viewController;
    
    topViewController.view.wantsLayer = YES;
    topViewController.view.layerContentsRedrawPolicy = NSViewLayerContentsRedrawOnSetNeedsDisplay;
    
    topViewController.view.alphaValue = 0;
        
    [bottomViewController.view addSubview:topViewController.view];
    
    [topViewController.view setFrame:bottomViewController.view.frame];
    topViewController.view.layer.backgroundColor = [NSColor colorWithRed:231.0/255.0
                                                                   green:231.0/255.0
                                                                    blue:231.0/255.0
                                                                   alpha:1].CGColor;

    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
        context.duration = 0.2;
        topViewController.view.animator.alphaValue = 1;
    } completionHandler:nil];
}

- (void)animateDismissalOfViewController:(NSViewController *)viewController
                      fromViewController:(NSViewController *)fromViewController {
    NSViewController *topViewController = viewController;
    
    topViewController.view.wantsLayer = YES;
    topViewController.view.layerContentsRedrawPolicy = NSViewLayerContentsRedrawOnSetNeedsDisplay;
    
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
        context.duration = 0.2;
        topViewController.view.animator.alphaValue = 0;
    } completionHandler:^{
        [topViewController.view removeFromSuperview];
    }];
}

@end
