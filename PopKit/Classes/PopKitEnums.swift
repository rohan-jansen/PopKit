//
//  PopKitEnums.swift
//  PopKit_Example
//
//  Created by Rohan Jansen on 2017/08/16.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation

public enum PopKitConstaint {
    case edges(left: Float?, right: Float?, top: Float?, bottom: Float?)
    case width(Float?)
    case height(Float?)
    case center(x: Float?, y: Float?)
}

public enum PopKitAnimation {
    case zoomIn(Float, animationOption: UIView.AnimationOptions)
    case zoomOut(Float, animationOption: UIView.AnimationOptions)
    case slideFromTop(animationOption: UIView.AnimationOptions)
    case slideFromLeft(animationOption: UIView.AnimationOptions)
    case slideFromRight(animationOption: UIView.AnimationOptions)
    case slideFromBottom(animationOption: UIView.AnimationOptions)
    case bounceFromTop(damping: Float, velocity: Float, animationOption: UIView.AnimationOptions)
    case bounceFromLeft(damping: Float, velocity: Float, animationOption: UIView.AnimationOptions)
    case bounceFromRight(damping: Float, velocity: Float, animationOption: UIView.AnimationOptions)
    case bounceFromBottom(damping: Float, velocity: Float, animationOption: UIView.AnimationOptions)
}

public enum PopKitBackgroundEffect {
    case blurLight
    case blurDark
    case transparentOverlay(Float)
}
