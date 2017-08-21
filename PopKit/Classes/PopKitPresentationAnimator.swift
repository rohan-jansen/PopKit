//
//  PopKitPresentationAnimator.swift
//  PopKit_Example
//
//  Created by Rohan Jansen on 2017/08/16.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import UIKit


class PopKitPresentationAnimator: NSObject, UIViewControllerAnimatedTransitioning, TransitionDuration {
    var kit: PopKit
    var transitionDuration: TimeInterval?
    
    init(with kit: PopKit) {
        self.kit = kit
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration ?? 0.7
    }
    
    func animateSlideAndScale(_ transitionContext: UIViewControllerContextTransitioning, _ controller: PopKitPresentationController, _ initialFrame: CGRect, _ finalFrame: CGRect, _ animationOption: UIViewAnimationOptions) {
        let animationDuration = transitionDuration(using: transitionContext)
        controller.presentedViewController.view.frame = initialFrame
        
        UIView.animate(withDuration: animationDuration, delay: 0, options: animationOption, animations: {
            controller.presentedViewController.view.frame = finalFrame
            controller.presentedViewController.view.transform = CGAffineTransform.identity
        }) { finished in
            transitionContext.completeTransition(finished)
        }
    }
    
    func animateBounce(_ damping: Float, _ velocity: Float, _ transitionContext: UIViewControllerContextTransitioning, _ controller: PopKitPresentationController, _ initialFrame: CGRect, _ finalFrame: CGRect, _ animationOption: UIViewAnimationOptions) {
        let animationDuration = transitionDuration(using: transitionContext)
        controller.presentedViewController.view.frame = initialFrame
        
        UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: CGFloat(damping), initialSpringVelocity: CGFloat(velocity), options: animationOption, animations: {
            controller.presentedViewController.view.frame = finalFrame
        }) { finished in
            transitionContext.completeTransition(finished)
        }
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerController = transitionContext.viewController(forKey: .to)!
        let controller = transitionContext.viewController(forKey: .to)?.presentationController as! PopKitPresentationController
        
        transitionContext.containerView.addSubview(controller.presentedViewController.view)
        
        let presentedFrame = containerController.view.frame
        var initialFrame = controller.frameOfPresentedViewInContainerView
        let finalFrame = controller.frameOfPresentedViewInContainerView
        
        switch kit.inAnimation {
        case .slideFromTop(let animationOption):
            initialFrame.origin.y = -presentedFrame.size.height
            animateSlideAndScale(transitionContext, controller, initialFrame, finalFrame, animationOption)
        case .slideFromLeft(let animationOption):
            initialFrame.origin.x = -presentedFrame.size.width
            animateSlideAndScale(transitionContext, controller, initialFrame, finalFrame, animationOption)
        case .slideFromRight(let animationOption):
            initialFrame.origin.x = presentedFrame.size.width
            animateSlideAndScale(transitionContext, controller, initialFrame, finalFrame, animationOption)
        case .slideFromBottom(let animationOption):
            initialFrame.origin.y = presentedFrame.size.height
            animateSlideAndScale(transitionContext, controller, initialFrame, finalFrame, animationOption)
        case .zoomIn(let scale, let animationOption):
            controller.presentedViewController.view.transform = CGAffineTransform(scaleX: CGFloat(scale), y: CGFloat(scale))
            animateSlideAndScale(transitionContext, controller, initialFrame, finalFrame, animationOption)
        case .zoomOut(let scale, let animationOption):
            controller.presentedViewController.view.transform = CGAffineTransform(scaleX: CGFloat(scale), y: CGFloat(scale))
            animateSlideAndScale(transitionContext, controller, initialFrame, finalFrame, animationOption)
        case .bounceFromTop(let damping, let velocity, let animationOption):
            initialFrame.origin.y = -presentedFrame.size.height
            animateBounce(damping, velocity, transitionContext, controller, initialFrame, finalFrame, animationOption)
        case .bounceFromLeft(let damping, let velocity, let animationOption):
            initialFrame.origin.x = -presentedFrame.size.width
            animateBounce(damping, velocity, transitionContext, controller, initialFrame, finalFrame, animationOption)
        case .bounceFromRight(let damping, let velocity, let animationOption):
            initialFrame.origin.x = presentedFrame.size.width
            animateBounce(damping, velocity, transitionContext, controller, initialFrame, finalFrame, animationOption)
        case .bounceFromBottom(let damping, let velocity, let animationOption):
            initialFrame.origin.y = presentedFrame.size.height
            animateBounce(damping, velocity, transitionContext, controller, initialFrame, finalFrame, animationOption)
        }
    }
}
