//
//  PopKitBackgroundEffectFactory.swift
//  PopKit_Example
//
//  Created by Rohan Jansen on 2017/08/16.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class PopKitBackgroundEffectFactory {
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
