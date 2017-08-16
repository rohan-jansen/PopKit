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
    
    func animateSlideAndScale(_ transitionContext: UIViewControllerContextTransitioning, _ controller: PopKitPresentationController, _ initialFrame: CGRect, _ finalFrame: CGRect) {
        let animationDuration = transitionDuration(using: transitionContext)
        UIView.animate(withDuration: animationDuration, animations: {
            controller.presentedViewController.view.frame = finalFrame
            controller.presentedViewController.view.transform = CGAffineTransform.identity
        }) { finished in
            transitionContext.completeTransition(finished)
        }
    }
    
    func animateBounce(_ damping: Float, _ velocity: Float, _ transitionContext: UIViewControllerContextTransitioning, _ controller: PopKitPresentationController, _ initialFrame: CGRect, _ finalFrame: CGRect) {
        let animationDuration = transitionDuration(using: transitionContext)
        controller.presentedViewController.view.frame = initialFrame
        
        UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: CGFloat(damping), initialSpringVelocity: CGFloat(velocity), options: .curveEaseInOut, animations: {
            controller.presentedViewController.view.frame = finalFrame
        }) { finished in
            transitionContext.completeTransition(finished)
        }
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerController = transitionContext.viewController(forKey: .from)!
        let toController = transitionContext.viewController(forKey: .to)!
        let controller = transitionContext.viewController(forKey: .from)?.presentationController as! PopKitPresentationController
        
        transitionContext.containerView.addSubview(controller.presentedViewController.view)
        
        let presentedFrame = containerController.view.frame
        var finalFrame = controller.frameOfPresentedViewInContainerView
        let toControllerViewFrame = toController.view.frame
        
        switch kit.outAnimation {
        case .slideTop:
            finalFrame.origin.y = toControllerViewFrame.size.height
            animateSlideAndScale(transitionContext, controller, presentedFrame, finalFrame)
        case .slideLeft:
            finalFrame.origin.x = toControllerViewFrame.size.width
            animateSlideAndScale(transitionContext, controller, presentedFrame, finalFrame)
        case .slideRight:
            finalFrame.origin.x = -toControllerViewFrame.size.width
            animateSlideAndScale(transitionContext, controller, presentedFrame, finalFrame)
        case .slideBottom:
            finalFrame.origin.y = -toControllerViewFrame.size.height
            animateSlideAndScale(transitionContext, controller, presentedFrame, finalFrame)
        case .zoomIn(let scale):
            controller.presentedViewController.view.transform = CGAffineTransform(scaleX: CGFloat(scale), y: CGFloat(scale))
            animateSlideAndScale(transitionContext, controller, presentedFrame, finalFrame)
        case .zoomOut(let scale):
            controller.presentedViewController.view.transform = CGAffineTransform(scaleX: CGFloat(scale), y: CGFloat(scale))
            animateSlideAndScale(transitionContext, controller, presentedFrame, finalFrame)
        case .bounceTop(let damping, let velocity):
            finalFrame.origin.y = toControllerViewFrame.size.height
            animateBounce(damping, velocity, transitionContext, controller, presentedFrame, finalFrame)
        case .bounceLeft(let damping, let velocity):
            finalFrame.origin.x = toControllerViewFrame.size.width
            animateBounce(damping, velocity, transitionContext, controller, presentedFrame, finalFrame)
        case .bounceRight(let damping, let velocity):
            finalFrame.origin.x = -toControllerViewFrame.size.width
            animateBounce(damping, velocity, transitionContext, controller, presentedFrame, finalFrame)
        case .bounceBottom(let damping, let velocity):
            finalFrame.origin.y = -toControllerViewFrame.size.height
            animateBounce(damping, velocity, transitionContext, controller, presentedFrame, finalFrame)
        }
    }
}
