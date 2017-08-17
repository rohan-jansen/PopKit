//
//  PopKitContainerController.swift
//  PopKit_Example
//
//  Created by Rohan Jansen on 2017/08/16.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

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


