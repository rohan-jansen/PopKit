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
            $0.constraints = [.center(x: 0, y: 0), .width(300), .height(300)] // .edges(left: 0, right: 50, top: 0, bottom: 0) .center(x: 0, y: 0), .width(200), .height(200) //.center(x: 0, y: 0), .width(300), .height(300)
            $0.inAnimation = .bounceTop(damping: 0.86, velocity: 2) //.zoomOut(1.3) // .bounceTop(damping: 0.86, velocity: 2) // .bounceInTop(damping: 0.86, velocity: 2) //.edges(left: 0, right: 0, top: 0, bottom: nil), .height(75)
            $0.outAnimation = .bounceBottom(damping: 0.86, velocity: 2) //.zoomIn(1.1) // .slideTop
            $0.backgroundEffect = .blurDark // .transparentOverlay(0.4)
            $0.popupView = TestView()
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
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hide))
        addGestureRecognizer(tap)
    }
    
    func hide() {
        dismiss()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}







