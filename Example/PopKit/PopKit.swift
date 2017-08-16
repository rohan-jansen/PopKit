//
//  PopKit.swift
//  PopKit_Example
//
//  Created by Rohan Jansen on 2017/08/16.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import UIKit


func PopKitBuilder(_ builder: (PopKit) -> Void) -> PopKit {
    let kit = PopKit()
    builder(kit)
    return kit
}

class PopKit {
    var popupView: PopView?
    var dismissAction: (() -> Void)?
    var mainAction: (() -> Void)?
    var inAnimation: PopKitAnimation = .slideTop
    var outAnimation: PopKitAnimation = .slideBottom
    var backgroundEffect: PopKitBackgroundEffect = .blurLight
    var constraints: [PopKitConstaint] = [.edges(left: 0, right: 0, top: 0, bottom: 0)]
    
    init() {
        NotificationCenter.default.addObserver(forName: .dismissPopKit, object: nil, queue: .main) { [weak self] (notification) in
            self?.dismiss()
        }
    }
}

extension PopKit {
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

protocol PopView { }

extension Notification.Name {
    static var dismissPopKit: NSNotification.Name {
        return Notification.Name("DismissPopKit")
    }
}

extension PopView where Self: UIView {
    func dismiss() {
        NotificationCenter.default.post(name: .dismissPopKit, object: nil)
    }
}

protocol TransitionDuration {
    var transitionDuration: TimeInterval? { get set }
}
