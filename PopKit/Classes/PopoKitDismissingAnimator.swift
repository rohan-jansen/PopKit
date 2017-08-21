//
//  PopoKitDismissingAnimator.swift
//  PopKit_Example
//
//  Created by Rohan Jansen on 2017/08/16.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class PopKitDismissingAnimator: NSObject, UIViewControllerAnimatedTransitioning, TransitionDuration {
    var kit: PopKit
    var transitionDuration: TimeInterval?
    
    init(with kit: PopKit) {
        self.kit = kit
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration ?? 0.7
    }
    
    func animateSlide(_ transitionContext: UIViewControllerContextTransitioning, _ controller: PopKitPresentationController, _ finalCenter: CGPoint, _ animationOption: UIViewAnimationOptions) {
        let animationDuration = transitionDuration(using: transitionContext)

        UIView.animate(withDuration: animationDuration, delay: 0, options: animationOption, animations: {
            controller.presentedViewController.view.center = finalCenter
            controller.presentedViewController.view.transform = CGAffineTransform.identity
        }) { finished in
            transitionContext.completeTransition(finished)
        }
    }
    
    func animateBounce(_ damping: Float, _ velocity: Float, _ transitionContext: UIViewControllerContextTransitioning, _ controller: PopKitPresentationController, _ finalCenter: CGPoint, _ animationOption: UIViewAnimationOptions) {
        let animationDuration = transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: CGFloat(damping), initialSpringVelocity: CGFloat(velocity), options: animationOption, animations: {
            controller.presentedViewController.view.center = finalCenter
        }) { finished in
            transitionContext.completeTransition(finished)
        }
    }
    
    fileprivate func animateScale(_ transitionContext: UIViewControllerContextTransitioning, _ controller: PopKitPresentationController, _ scale: (Float), _ animationOption: UIViewAnimationOptions) {
        let animationDuration = transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: animationDuration, delay: 0, options: animationOption, animations: {
            controller.presentedViewController.view.transform = CGAffineTransform(scaleX: CGFloat(scale), y: CGFloat(scale))
        }) { finished in
            transitionContext.completeTransition(finished)
        }
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerController = transitionContext.viewController(forKey: .from)!
        let toController = transitionContext.viewController(forKey: .to)!
        let controller = transitionContext.viewController(forKey: .from)?.presentationController as! PopKitPresentationController
        
        transitionContext.containerView.addSubview(controller.presentedViewController.view)
        
        var finalFrame = controller.frameOfPresentedViewInContainerView
        let toControllerViewFrame = toController.view.frame
        
        switch kit.outAnimation {
        case .slideFromTop(let animationOption):
            finalFrame.origin.y = toControllerViewFrame.size.height * 2
            animateSlide(transitionContext, controller, CGPoint(x: containerController.view.center.x, y: finalFrame.origin.y), animationOption)
        case .slideFromLeft(let animationOption):
            finalFrame.origin.x = toControllerViewFrame.size.width * 2
            animateSlide(transitionContext, controller, CGPoint(x: finalFrame.origin.x, y: containerController.view.center.y), animationOption)
        case .slideFromRight(let animationOption):
            finalFrame.origin.x = -toControllerViewFrame.size.width * 2
            animateSlide(transitionContext, controller, CGPoint(x: finalFrame.origin.x, y: containerController.view.center.y), animationOption)
        case .slideFromBottom(let animationOption):
            finalFrame.origin.y = -toControllerViewFrame.size.height * 2
            animateSlide(transitionContext, controller, CGPoint(x: containerController.view.center.x, y: finalFrame.origin.y), animationOption)
        case .zoomIn(let scale, let animationOption):
            animateScale(transitionContext, controller, scale, animationOption)
        case .zoomOut(let scale, let animationOption):
            animateScale(transitionContext, controller, scale, animationOption)
        case .bounceFromTop(let damping, let velocity, let animationOption):
            finalFrame.origin.y = toControllerViewFrame.size.height * 2
            animateBounce(damping, velocity, transitionContext, controller, CGPoint(x: containerController.view.center.x, y: finalFrame.origin.y), animationOption)
        case .bounceFromLeft(let damping, let velocity, let animationOption):
            finalFrame.origin.x = toControllerViewFrame.size.width * 2
            animateBounce(damping, velocity, transitionContext, controller, CGPoint(x: finalFrame.origin.x, y: containerController.view.center.y), animationOption)
        case .bounceFromRight(let damping, let velocity, let animationOption):
            finalFrame.origin.x = -toControllerViewFrame.size.width * 2
            animateBounce(damping, velocity, transitionContext, controller, CGPoint(x: finalFrame.origin.x, y: containerController.view.center.y), animationOption)
        case .bounceFromBottom(let damping, let velocity, let animationOption):
            finalFrame.origin.y = -toControllerViewFrame.size.height * 2
            animateBounce(damping, velocity, transitionContext, controller, CGPoint(x: containerController.view.center.x, y: finalFrame.origin.y), animationOption)
        }
    }
}
