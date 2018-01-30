//
//  ViewController.swift
//  PopKit
//
//  Created by rohan-jansen on 08/10/2017.
//  Copyright (c) 2017 rohan-jansen. All rights reserved.
//

import UIKit
import PopKit

extension Bundle {
    
    static func loadView<T>(fromNib name: String, withType type: T.Type) -> T where T: UIView {
        if let view = Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.first as? T {
            return view
        }
        
        return UIView() as! T
    }
}

class ViewController: UIViewController {
    
    var sideMenu: PopKit {
        return PopKitBuilder() {
            $0.constraints = [.edges(left: 0, right: nil, top: 0, bottom: 0), .width(275)]
            $0.inAnimation = .bounceFromLeft(damping: 0.82, velocity: 2, animationOption: .curveEaseInOut)
            $0.outAnimation = .bounceFromRight(damping: 0.72, velocity: 2, animationOption: .curveEaseInOut)
            $0.backgroundEffect = .blurDark
            $0.popupViewController = SideMenuViewController.fromStoryboard()
        }
    }
    
    var topNotification: PopKit {
        return PopKitBuilder() {
            $0.constraints = [.edges(left: 0, right: 0, top: 0, bottom:nil), .height(90)]
            $0.inAnimation = .bounceFromTop(damping: 0.9, velocity: 2, animationOption: .curveEaseInOut)
            $0.outAnimation = .bounceFromBottom(damping: 0.86, velocity: 2, animationOption: .curveEaseInOut)
            $0.backgroundEffect = .blurDark
            $0.transitionSpeed = 0.3
            $0.popupView = NotificationView.loadView()
        }
    }
    
    var bottomMenu: PopKit {
        return PopKitBuilder() {
            $0.constraints = [.edges(left: 0, right: 0, top: nil, bottom:0), .height(400)]
            $0.inAnimation = .bounceFromBottom(damping: 0.86, velocity: 2, animationOption: .curveEaseInOut)
            $0.outAnimation = .bounceFromTop(damping: 0.72, velocity: 2, animationOption: .curveEaseInOut)
            $0.backgroundEffect = .transparentOverlay(0.5)
            $0.transitionSpeed = 0.3
            $0.popupView = TestView(radius: 0)
        }
    }
    
    var slideFromBottom: PopKit {
        return PopKitBuilder() {
            $0.constraints = [.center(x: 0, y: 0), .width(300), .height(300)]
            $0.inAnimation = .slideFromBottom(animationOption: .curveEaseOut)
            $0.outAnimation = .slideFromTop(animationOption: .curveEaseInOut)
            $0.backgroundEffect = .blurDark
            $0.transitionSpeed = 0.3
            $0.popupView = TestView()
        }
    }
    
    var bounceFromTop: PopKit {
        return PopKitBuilder() {
            $0.constraints = [.center(x: 0, y: 0), .width(300), .height(350)]
            $0.inAnimation = .bounceFromTop(damping: 0.72, velocity: 2, animationOption: .curveEaseInOut)
            $0.outAnimation = .bounceFromBottom(damping: 0.86, velocity: 2, animationOption: .curveEaseInOut)
            $0.backgroundEffect = .blurDark
            $0.popupView = CenterModalView.loadView()
        }
    }
    var zoomIn: PopKit {
        return PopKitBuilder() {
            $0.constraints = [.center(x: 0, y: 0), .width(300), .height(300)]
            $0.inAnimation = .zoomOut(1.2, animationOption: .curveEaseInOut)
            $0.outAnimation = .bounceFromBottom(damping: 0.86, velocity: 2, animationOption: .curveEaseInOut)
            $0.backgroundEffect = .blurDark
            $0.transitionSpeed = 0.46
            $0.popupView = TestView()
        }
    }

    @IBOutlet var animationTypeContainer: UIView!
    
    @IBAction func animationSelected(_ sender: UISegmentedControl) {
        animationType = AnimationType(rawValue: sender.selectedSegmentIndex)!
    }
    
    var animationType: AnimationType = .zoom {
        didSet {
            animationTypeContainer.subviews.forEach { $0.removeFromSuperview() }
            let view: UIView
            switch animationType {
            case .zoom:
                view = Bundle.loadView(fromNib: "ZoomAnimationView", withType: ZoomAnimationView.self)
            case .slide:
                view = Bundle.loadView(fromNib: "SlideAnimation", withType: SlideAnimation.self)
            case .bounce:
                view = Bundle.loadView(fromNib: "BounceAnimation", withType: BounceAnimation.self)
            }
            
            animationTypeContainer.addSubview(view)

            view.leftAnchor.constraint(equalTo: animationTypeContainer.leftAnchor, constant: 0).isActive = true
            view.rightAnchor.constraint(equalTo: animationTypeContainer.rightAnchor, constant: 0).isActive = true
            view.topAnchor.constraint(equalTo: animationTypeContainer.topAnchor, constant: 0).isActive = true
            view.bottomAnchor.constraint(equalTo: animationTypeContainer.bottomAnchor, constant: 0).isActive = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animationType = .zoom
    }
}

enum AnimationType: Int {
    case zoom
    case slide
    case bounce
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







