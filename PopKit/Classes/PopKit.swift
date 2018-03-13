//
//  PopKit.swift
//  PopKit_Example
//
//  Created by Rohan Jansen on 2017/08/16.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

public open protocol PopKitable {
    public var popupView: UIView?
    public var popupViewController: UIViewController?
    public var dismissAction: (() -> Void)?
    public var mainAction: (() -> Void)?
    public var transitionSpeed: TimeInterval
    public var inAnimation: PopKitAnimation
    public var outAnimation: PopKitAnimation
    public var backgroundEffect: PopKitBackgroundEffect
    public var constraints: [PopKitConstaint]
    public var additionalConstraints: [PopKitConstaint]
    
    public func show()
    public func dismiss()
    public static func dismiss()
}


public func PopKitBuilder(_ builder: (PopKit) -> Void) -> PopKit {
    let kit = PopKit()
    builder(kit)
    return kit
}

public class PopKit: PopKitable {
    public var popupView: UIView?
    public var popupViewController: UIViewController?
    public var dismissAction: (() -> Void)?
    public var mainAction: (() -> Void)?
    public var transitionSpeed: TimeInterval = 0.6
    public var inAnimation: PopKitAnimation = .slideFromTop(animationOption: .curveEaseInOut)
    public var outAnimation: PopKitAnimation = .slideFromBottom(animationOption: .curveEaseInOut)
    public var backgroundEffect: PopKitBackgroundEffect = .blurDark
    public var constraints: [PopKitConstaint] = [.edges(left: 0, right: 0, top: 0, bottom: 0)]
    public var additionalConstraints: [PopKitConstaint] = [.edges(left: 0, right: 0, top: 0, bottom: 0)]
    
    init() {
        NotificationCenter.default.addObserver(forName: .dismissPopKit, object: nil, queue: .main) { [weak self] (notification) in
            self?.dismiss()
        }
    }
}

extension PopKit {
    public func show() {
        let container = PopKitContainerController.fromStoryboard()
        container.popKit = self
        
        if let root = UIApplication.shared.keyWindow?.rootViewController {
            root.present(container, animated: true, completion: nil)
        }
    }
    
    public func dismiss() {
        if let root = UIApplication.shared.keyWindow?.rootViewController, let presented = root.presentedViewController {
            presented.dismiss(animated: true, completion: nil)
        }
    }
}

extension Notification.Name {
    public static var dismissPopKit: NSNotification.Name {
        return Notification.Name("DismissPopKit")
    }
}

extension PopKit {
    public static func dismiss() {
        NotificationCenter.default.post(name: .dismissPopKit, object: nil)
    }
}

protocol TransitionDuration {
    var transitionDuration: TimeInterval? { get set }
}
