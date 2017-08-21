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
    case zoomIn(Float, animationOption: UIViewAnimationOptions)
    case zoomOut(Float, animationOption: UIViewAnimationOptions)
    case slideFromTop(animationOption: UIViewAnimationOptions)
    case slideFromLeft(animationOption: UIViewAnimationOptions)
    case slideFromRight(animationOption: UIViewAnimationOptions)
    case slideFromBottom(animationOption: UIViewAnimationOptions)
    case bounceFromTop(damping: Float, velocity: Float, animationOption: UIViewAnimationOptions)
    case bounceFromLeft(damping: Float, velocity: Float, animationOption: UIViewAnimationOptions)
    case bounceFromRight(damping: Float, velocity: Float, animationOption: UIViewAnimationOptions)
    case bounceFromBottom(damping: Float, velocity: Float, animationOption: UIViewAnimationOptions)
}

public enum PopKitBackgroundEffect {
    case blurLight
    case blurDark
    case transparentOverlay(Float)
}
