//
//  PresentationAnimator.m
//  AutoPrintr-mac
//
//  Created by Cata Haidau on 30/08/16.
//  Copyright © 2016 Catalin Haidau. All rights reserved.
//

#import "PresentationAnimator.h"

@implementation PresentationAnimator

- (void)animatePresentationOfViewController:(NSViewController *)viewController
                         fromViewController:(NSViewController *)fromViewController {
    NSViewController *bottomViewController = fromViewController;
    NSViewController *topViewController = viewController;
    
    topViewController.view.wantsLayer = YES;
    topViewController.view.layerContentsRedrawPolicy = NSViewLayerContentsRedrawOnSetNeedsDisplay;
    
    topViewController.view.alphaValue = 0;
    
    [bottomViewController.view addSubview:topViewController.view];
    
    [topViewController.view setFrame:bottomViewController.view.frame];
    topViewController.view.layer.backgroundColor = [NSColor grayColor].CGColor;
    
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
        context.duration = 0.5;
        topViewController.view.animator.alphaValue = 0;
    } completionHandler:^{
        [topViewController.view removeFromSuperview];
    }];
}

@end
