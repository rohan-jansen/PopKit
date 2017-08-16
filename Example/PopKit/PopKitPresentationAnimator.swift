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
    
    func animateSlideAndScale(_ transitionContext: UIViewControllerContextTransitioning, _ controller: PopKitPresentationController, _ initialFrame: CGRect, _ finalFrame: CGRect) {
        let animationDuration = transitionDuration(using: transitionContext)
        controller.presentedViewController.view.frame = initialFrame
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
        
        let containerController = transitionContext.viewController(forKey: .to)!
        let controller = transitionContext.viewController(forKey: .to)?.presentationController as! PopKitPresentationController
        
        transitionContext.containerView.addSubview(controller.presentedViewController.view)
        
        let presentedFrame = containerController.view.frame
        var initialFrame = controller.frameOfPresentedViewInContainerView
        let finalFrame = controller.frameOfPresentedViewInContainerView
        
        switch kit.inAnimation {
        case .slideTop:
            initialFrame.origin.y = -presentedFrame.size.height
            animateSlideAndScale(transitionContext, controller, initialFrame, finalFrame)
        case .slideLeft:
            initialFrame.origin.x = -presentedFrame.size.width
            animateSlideAndScale(transitionContext, controller, initialFrame, finalFrame)
        case .slideRight:
            initialFrame.origin.x = presentedFrame.size.width
            animateSlideAndScale(transitionContext, controller, initialFrame, finalFrame)
        case .slideBottom:
            initialFrame.origin.y = presentedFrame.size.height
            animateSlideAndScale(transitionContext, controller, initialFrame, finalFrame)
        case .zoomIn(let scale):
            controller.presentedViewController.view.transform = CGAffineTransform(scaleX: CGFloat(scale), y: CGFloat(scale))
            animateSlideAndScale(transitionContext, controller, initialFrame, finalFrame)
        case .zoomOut(let scale):
            controller.presentedViewController.view.transform = CGAffineTransform(scaleX: CGFloat(scale), y: CGFloat(scale))
            animateSlideAndScale(transitionContext, controller, initialFrame, finalFrame)
        case .bounceTop(let damping, let velocity):
            initialFrame.origin.y = -presentedFrame.size.height
            animateBounce(damping, velocity, transitionContext, controller, initialFrame, finalFrame)
        case .bounceLeft(let damping, let velocity):
            initialFrame.origin.x = -presentedFrame.size.width
            animateBounce(damping, velocity, transitionContext, controller, initialFrame, finalFrame)
        case .bounceRight(let damping, let velocity):
            initialFrame.origin.x = presentedFrame.size.width
            animateBounce(damping, velocity, transitionContext, controller, initialFrame, finalFrame)
        case .bounceBottom(let damping, let velocity):
            initialFrame.origin.y = presentedFrame.size.height
            animateBounce(damping, velocity, transitionContext, controller, initialFrame, finalFrame)
        }
    }
}
