//
//  ViewController.swift
//  PopKit
//
//  Created by rohan-jansen on 08/10/2017.
//  Copyright (c) 2017 rohan-jansen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var testView: PopView {
        return TestView()
    }
    
    var popkit: PopKit {
        return PopKitBuilder() {
            $0.constraints = [.center(x: 0, y: 0), .width(300), .height(300)] // .edges(left: 0, right: 50, top: 0, bottom: 0) .center(x: 0, y: 0), .width(200), .height(200)
            $0.inAnimation = .bounceInBottom(damping: 0.86, velocity: 2)
            $0.backgroundEffect = .transparentOverlay(0.4)
            $0.popupView = testView
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        popkit.show()
    }
}

class TestView: UIView, PopView {
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        layer.cornerRadius = 15
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 0.5
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

enum PopKitConstaint {
    case edges(left: Float?, right: Float?, top: Float?, bottom: Float?)
    case width(Float?)
    case height(Float?)
    case center(x: Float?, y: Float?)
}

enum PopKitAnimation {
    case zoomIn(Float)
    case zoomOut(Float)
    case slideInTop
    case slideInLeft
    case slideInRight
    case slideInBottom
    case bounceInTop(damping: Float, velocity: Float)
    case bounceInLeft(damping: Float, velocity: Float)
    case bounceInRight(damping: Float, velocity: Float)
    case bounceInBottom(damping: Float, velocity: Float)
}

enum PopKitBackgroundEffect {
    case blurLight
    case blurDark
    case transparentOverlay(Float)
}

internal func PopKitBuilder(_ builder: (PopKit) -> Void) -> PopKit {
    let kit = PopKit()
    builder(kit)
    return kit
}

protocol PopView { }

extension PopView where Self: UIView {
    
    func dismiss() {
        
    }
}

class PopKit {
    var popupView: PopView?
    var dismissAction: (() -> Void)?
    var mainAction: (() -> Void)?
    var inAnimation: PopKitAnimation = .slideInTop
    var outAnimation: PopKitAnimation = .slideInBottom
    var backgroundEffect: PopKitBackgroundEffect = .blurLight
    var constraints: [PopKitConstaint] = [.edges(left: 0, right: 0, top: 0, bottom: 0)]
    
    func show() {
        let container = PopKitContainerController.fromStoryboard()
        container.popKit = self
        
        if let root = UIApplication.shared.keyWindow?.rootViewController {
            root.present(container, animated: true, completion: nil)
        }
    }
    
    func dismiss() {
        if let root = UIApplication.shared.keyWindow?.rootViewController, let presented = root.presentedViewController {
            presented.dismiss(animated: true, completion: nil)
        }
    }
}

class PopKitContainerController: UIViewController, UIViewControllerTransitioningDelegate {
    var popKit: PopKit?
    
    static func fromStoryboard() -> PopKitContainerController {
        return UIStoryboard(name: String(describing: PopKit.self), bundle: nil).instantiateViewController(withIdentifier: String(describing: PopKitContainerController.self)) as! PopKitContainerController
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        transitioningDelegate = self
        modalPresentationStyle = .custom
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return PopKitPresentationController(presentedViewController: presented, presenting: presenting, popKit: popKit!)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PopKitPresentationAnimator(with: popKit!)
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PopKitDismissingAnimator(with: popKit!)
    }
}

class PopKitPresentationController: UIPresentationController {
    var popKit: PopKit?
    
    init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?, popKit: PopKit?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        self.popKit = popKit
        
        if let kit = popKit, let popup = kit.popupView as? UIView {
            popup.translatesAutoresizingMaskIntoConstraints = false
            presentedViewController.view.addSubview(popup)
            
            kit.constraints.forEach({ (kitConstraint) in
                
                switch kitConstraint {
                case .center(x: let x, y: let y):
                    if let x = x {
                        popup.centerXAnchor.constraint(equalTo: presentedViewController.view.centerXAnchor, constant: CGFloat(x)).isActive = true

                    }
                    
                    if let y = y {
                        popup.centerYAnchor.constraint(equalTo: presentedViewController.view.centerYAnchor, constant: CGFloat(y)).isActive = true
                    }
                    
                case .edges(left: let left, right: let right, top: let top, bottom: let bottom):
                    if let left = left {
                        popup.leftAnchor.constraint(equalTo: presentedViewController.view.leftAnchor, constant: CGFloat(left)).isActive = true
                    }
                    
                    if let right = right {
                        popup.rightAnchor.constraint(equalTo: presentedViewController.view.rightAnchor, constant: -1 * CGFloat(right)).isActive = true
                    }
                    
                    if let top = top {
                        popup.topAnchor.constraint(equalTo: presentedViewController.view.topAnchor, constant: CGFloat(top)).isActive = true
                    }
                    
                    if let bottom = bottom {
                        popup.bottomAnchor.constraint(equalTo: presentedViewController.view.bottomAnchor, constant: -1 * CGFloat(bottom)).isActive = true
                    }
                    
                case .width(let width):
                    if let width = width {
                        popup.widthAnchor.constraint(equalToConstant: CGFloat(width)).isActive = true
                    }
                    
                case .height(let height):
                    if let height = height {
                        popup.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true
                    }
                }
            })

            presentedViewController.view.layoutIfNeeded()
            
        }
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let popupView = popKit?.popupView else {
            return .zero
        }
        
        return (popupView as! UIView).frame
    }
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        let effectView = PopKitBackgroundEffectManager.create(from: popKit!.backgroundEffect)
        effectView.frame = presentingViewController.view.frame
        effectView.alpha = 0
        presentingViewController.view.addSubview(effectView)
        
        UIView.animate(withDuration: 0.5) { [unowned self] in
            switch self.popKit!.backgroundEffect {
            case .blurDark, .blurLight:
                effectView.alpha = 1
            case .transparentOverlay(let alpha):
                effectView.alpha = CGFloat(alpha)
            }
        }
    }
}

class PopKitBackgroundEffectManager {
    class func create(from effect: PopKitBackgroundEffect) -> UIView {
        switch effect {
        case .blurDark:
            let blurEffect = UIBlurEffect(style: .dark)
            return  UIVisualEffectView(effect: blurEffect)
        case .blurLight:
            let blurEffect = UIBlurEffect(style: .light)
            return UIVisualEffectView(effect: blurEffect)
        case .transparentOverlay(_):
            let overlayView = UIView()
            overlayView.backgroundColor = .black
            return overlayView
        }
    }
}

protocol TransitionDuration {
    var transitionDuration: TimeInterval? { get set }
}

class PopKitPresentationAnimator: NSObject, UIViewControllerAnimatedTransitioning, TransitionDuration {
    var kit: PopKit
    var transitionDuration: TimeInterval?
    
    init(with kit: PopKit) {
        self.kit = kit
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration ?? 0.7
    }
    
    fileprivate func animateSlideAndScale(_ transitionContext: UIViewControllerContextTransitioning, _ controller: PopKitPresentationController, _ initialFrame: CGRect, _ finalFrame: CGRect) {
        let animationDuration = transitionDuration(using: transitionContext)
        controller.presentedViewController.view.frame = initialFrame
        UIView.animate(withDuration: animationDuration, animations: {
            controller.presentedViewController.view.frame = finalFrame
            controller.presentedViewController.view.transform = CGAffineTransform.identity
        }) { finished in
            transitionContext.completeTransition(finished)
        }
    }
    
    fileprivate func animateBounce(_ damping: Float, _ velocity: Float, _ transitionContext: UIViewControllerContextTransitioning, _ controller: PopKitPresentationController, _ initialFrame: CGRect, _ finalFrame: CGRect) {
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
        case .slideInTop:
            initialFrame.origin.y = -presentedFrame.size.height
            animateSlideAndScale(transitionContext, controller, initialFrame, finalFrame)
        case .slideInLeft:
            initialFrame.origin.x = -presentedFrame.size.width
            animateSlideAndScale(transitionContext, controller, initialFrame, finalFrame)
        case .slideInRight:
            initialFrame.origin.x = presentedFrame.size.width
            animateSlideAndScale(transitionContext, controller, initialFrame, finalFrame)
        case .slideInBottom:
            initialFrame.origin.y = presentedFrame.size.height
            animateSlideAndScale(transitionContext, controller, initialFrame, finalFrame)
        case .zoomIn(let scale):
            controller.presentedViewController.view.transform = CGAffineTransform(scaleX: CGFloat(scale), y: CGFloat(scale))
            animateSlideAndScale(transitionContext, controller, initialFrame, finalFrame)
        case .zoomOut(let scale):
            controller.presentedViewController.view.transform = CGAffineTransform(scaleX: CGFloat(scale), y: CGFloat(scale))
            animateSlideAndScale(transitionContext, controller, initialFrame, finalFrame)
        case .bounceInTop(let damping, let velocity):
            initialFrame.origin.y = -presentedFrame.size.height
            animateBounce(damping, velocity, transitionContext, controller, initialFrame, finalFrame)
        case .bounceInLeft(let damping, let velocity):
            initialFrame.origin.x = -presentedFrame.size.width
            animateBounce(damping, velocity, transitionContext, controller, initialFrame, finalFrame)
        case .bounceInRight(let damping, let velocity):
            initialFrame.origin.x = presentedFrame.size.width
            animateBounce(damping, velocity, transitionContext, controller, initialFrame, finalFrame)
        case .bounceInBottom(let damping, let velocity):
            initialFrame.origin.y = presentedFrame.size.height
            animateBounce(damping, velocity, transitionContext, controller, initialFrame, finalFrame)
        }
    }
}

class PopKitDismissingAnimator: NSObject, UIViewControllerAnimatedTransitioning, TransitionDuration {
    var kit: PopKit
    var transitionDuration: TimeInterval?
    
    init(with kit: PopKit) {
        self.kit = kit
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration ?? 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        transitionContext.completeTransition(true)
    }
}


