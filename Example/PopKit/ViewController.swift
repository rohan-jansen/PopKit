//
//  ViewController.swift
//  PopKit
//
//  Created by rohan-jansen on 08/10/2017.
//  Copyright (c) 2017 rohan-jansen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var popkit: PopKit {
        
        
        return PopKitBuilder() {
            let testView = TestView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
            testView.backgroundColor = .red
            
            $0.popupView = testView
            $0.mainAction = { print("Did perform main action") }
            $0.dismissAction = { print("Did perform dimiss action") }
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        popkit.show()
    }
}

class TestView: UIView, PopView {
    
}


enum PopKitAnimation {
    case zoomIn(Float)
    case zoomOut(Float)
    case fromTop
    case fromLeft
    case fromRight
    case fromBottom
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
    var inAnimation: PopKitAnimation = .fromTop
    var outAnimation: PopKitAnimation = .fromBottom
    var backgroundEffect: PopKitBackgroundEffect = .blurLight
    
    func show() {
        let container = PopKitContainerController.fromStoryboard()
        container.popKit = self
        if let root = UIApplication.shared.keyWindow?.rootViewController {
            root.present(container, animated: true, completion: nil)
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
        return PopKitPresentationController(presentedViewController: presented, presenting: presenting, popView: popKit!.popupView)
    }
    
//    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return PopKitPresentationAnimator(with: popKit!.inAnimation)
//    }
//
//    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return PopKitDismissingAnimator(with: popKit!.outAnimation)
//    }
}

class PopKitPresentationController: UIPresentationController {
    var popupView: PopView?
    
    init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?, popView: PopView?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        self.popupView = popView
        
        if let popup = popupView {
            presentedViewController.view.addSubview(popup as! UIView)
        }
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        return (popupView as! UIView).frame
    }
}

protocol TransitionDuration {
    var transitionDuration: TimeInterval? { get set }
}

class PopKitPresentationAnimator: NSObject, UIViewControllerAnimatedTransitioning, TransitionDuration {
    var inAnimation: PopKitAnimation = .fromTop
    var transitionDuration: TimeInterval?
    
    init(with animation: PopKitAnimation) {
        inAnimation = animation
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration ?? 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        transitionContext.completeTransition(true)
    }
}

class PopKitDismissingAnimator: NSObject, UIViewControllerAnimatedTransitioning, TransitionDuration {
    var outAnimation: PopKitAnimation = .fromBottom
    var transitionDuration: TimeInterval?
    
    init(with animation: PopKitAnimation) {
        outAnimation = animation
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration ?? 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        transitionContext.completeTransition(true)
    }
}


