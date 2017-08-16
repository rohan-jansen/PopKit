//
//  PopKitPresentationController.swift
//  PopKit_Example
//
//  Created by Rohan Jansen on 2017/08/16.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class PopKitPresentationController: UIPresentationController {
    var popKit: PopKit?
    var effectView: UIView = UIView()
    
    init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?, popKit: PopKit?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        self.popKit = popKit
        
        if let kit = popKit, let popup = kit.popupView as? UIView {
            
            popup.translatesAutoresizingMaskIntoConstraints = false
            presentedViewController.view.addSubview(popup)
            
            kit.constraints.forEach({ (kitConstraint) in
                activateConstraints(kitConstraint, popup)
            })
            
            presentedViewController.view.layoutIfNeeded()
        }
    }
    
    fileprivate func activateConstraints(_ kitConstraint: (PopKitConstaint), _ popup: UIView) {
        switch kitConstraint {
        case .center(x: let x, y: let y):
            activateXAndYAnchor(x, y, popup)
            
        case .edges(left: let left, right: let right, top: let top, bottom: let bottom):
            activateEdges(left, right, top, bottom, popup)
            
        case .width(let width):
            activateWidth(width, popup)
            
        case .height(let height):
            activateHeight(height, popup)
        }
    }
    
    fileprivate func activateXAndYAnchor(_ x: Float?, _ y: Float?, _ popup: UIView) {
        if let x = x {
            popup.centerXAnchor.constraint(equalTo: presentedViewController.view.centerXAnchor, constant: CGFloat(x)).isActive = true
            
        }
        
        if let y = y {
            popup.centerYAnchor.constraint(equalTo: presentedViewController.view.centerYAnchor, constant: CGFloat(y)).isActive = true
        }
    }
    
    fileprivate func activateEdges(_ left: Float?, _ right: Float?, _ top: Float?, _ bottom: Float?, _ popup: UIView) {
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
    }
    
    fileprivate func activateWidth(_ width: (Float?), _ popup: UIView) {
        if let width = width {
            popup.widthAnchor.constraint(equalToConstant: CGFloat(width)).isActive = true
        }
    }
    
    fileprivate func activateHeight(_ height: (Float?), _ popup: UIView) {
        if let height = height {
            popup.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true
        }
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let popupView = popKit?.popupView else {
            return .zero
        }
        
        return (popupView as! UIView).frame
    }
    
    override func dismissalTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        UIView.animate(withDuration: 0.7, animations: { [unowned self] in
            self.effectView.alpha = 0
        }) { (done) in
            self.effectView.removeFromSuperview()
        }
    }
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        effectView = PopKitBackgroundEffectManager.create(from: popKit!.backgroundEffect)
        effectView.frame = presentingViewController.view.frame
        effectView.alpha = 0
        presentingViewController.view.addSubview(effectView)
        
        UIView.animate(withDuration: 0.7) { [unowned self] in
            switch self.popKit!.backgroundEffect {
            case .blurDark, .blurLight:
                self.effectView.alpha = 1
            case .transparentOverlay(let alpha):
                self.effectView.alpha = CGFloat(alpha)
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
