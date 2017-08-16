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
            $0.constraints = [.edges(left: 0, right: 0, top: 0, bottom: nil), .height(75)] // .edges(left: 0, right: 50, top: 0, bottom: 0) .center(x: 0, y: 0), .width(200), .height(200) //.center(x: 0, y: 0), .width(300), .height(300)
            $0.inAnimation = .slideTop // .bounceInTop(damping: 0.86, velocity: 2)
            $0.outAnimation = .slideBottom
            $0.backgroundEffect = .blurDark // .transparentOverlay(0.4)
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
//        layer.cornerRadius = 15
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







