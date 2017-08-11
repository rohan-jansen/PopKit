//
//  ViewController.swift
//  PopKit
//
//  Created by rohan-jansen on 08/10/2017.
//  Copyright (c) 2017 rohan-jansen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = PopKitBuilder() {
            $0.backgroundEffect = .blurDark
            $0.inAnimation = .fromBottom
            $0.outAnimation = .fromTop
            $0.popupView = TestView()
            $0.mainAction = { print("Did perform main action") }
            $0.dismissAction = { print("Did perform dimiss action") }
        }
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
}



