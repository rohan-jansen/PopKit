//
//  ViewController.swift
//  PopKit
//
//  Created by rohan-jansen on 08/10/2017.
//  Copyright (c) 2017 rohan-jansen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var sideMenu: PopKit {
        return PopKitBuilder() {
            $0.constraints = [.edges(left: 0, right: nil, top: 0, bottom: 0), .width(275)]
            $0.inAnimation = .bounceLeft(damping: 0.82, velocity: 2)
            $0.outAnimation = .bounceRight(damping: 0.72, velocity: 2)
            $0.backgroundEffect = .blurDark
            $0.popupViewController = SideMenuViewController.fromStoryboard()
        }
    }
    
    var topNotification: PopKit {
        return PopKitBuilder() {
            $0.constraints = [.edges(left: 0, right: 0, top: 0, bottom:nil), .height(75)]
            $0.inAnimation = .bounceTop(damping: 0.72, velocity: 2)
            $0.outAnimation = .bounceBottom(damping: 0.86, velocity: 2)
            $0.backgroundEffect = .blurDark
            $0.popupView = TestView(radius: 0)
        }
    }
    
    var bottomMenu: PopKit {
        return PopKitBuilder() {
            $0.constraints = [.edges(left: 0, right: 0, top: nil, bottom:0), .height(400)]
            $0.inAnimation = .bounceBottom(damping: 0.86, velocity: 2)
            $0.outAnimation = .bounceTop(damping: 0.72, velocity: 2)
            $0.backgroundEffect = .transparentOverlay(0.5)
            $0.popupView = TestView(radius: 0)
        }
    }
    
    var slideFromBottom: PopKit {
        return PopKitBuilder() {
            $0.constraints = [.center(x: 0, y: 0), .width(300), .height(300)]
            $0.inAnimation = .slideBottom
            $0.outAnimation = .slideTop
            $0.backgroundEffect = .blurDark
            $0.popupView = TestView()
        }
    }
    
    var bounceFromTop: PopKit {
        return PopKitBuilder() {
            $0.constraints = [.center(x: 0, y: 0), .width(300), .height(300)]
            $0.inAnimation = .bounceTop(damping: 0.72, velocity: 2)
            $0.outAnimation = .bounceBottom(damping: 0.86, velocity: 2)
            $0.backgroundEffect = .blurDark
            $0.popupView = TestView()
        }
    }
    var zoomIn: PopKit {
        return PopKitBuilder() {
            $0.constraints = [.center(x: 0, y: 0), .width(300), .height(300)]
            $0.inAnimation = .zoomOut(1.2)
            $0.outAnimation = .bounceBottom(damping: 0.86, velocity: 2)
            $0.backgroundEffect = .blurLight
            $0.popupView = TestView()
        }
    }

    @IBAction func showSideMenu(_ sender: Any) {
        sideMenu.show()
    }
    @IBAction func showTopNotification(_ sender: Any) {
        topNotification.show()
    }
    
    @IBAction func showBottomMenu(_ sender: Any) {
        bottomMenu.show()
    }
    @IBAction func showSlideFromBottom(_ sender: Any) {
        slideFromBottom.show()
    }
    
    @IBAction func showBounceFromTop(_ sender: Any) {
        bounceFromTop.show()
    }
    
    @IBAction func showZoomIn(_ sender: Any) {
        zoomIn.show()
    }
}

class TestView: UIView {
    init(radius: Float = 15) {
        super.init(frame: .zero)
        backgroundColor = .white
        layer.cornerRadius = CGFloat(radius)
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 0.5
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}







