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
    case zoomIn(Float)
    case zoomOut(Float)
    case slideTop
    case slideLeft
    case slideRight
    case slideBottom
    case bounceTop(damping: Float, velocity: Float)
    case bounceLeft(damping: Float, velocity: Float)
    case bounceRight(damping: Float, velocity: Float)
    case bounceBottom(damping: Float, velocity: Float)
}

public enum PopKitBackgroundEffect {
    case blurLight
    case blurDark
    case transparentOverlay(Float)
}
