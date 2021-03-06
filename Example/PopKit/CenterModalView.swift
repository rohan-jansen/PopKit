//
//  CenterModalView.swift
//  PopKit_Example
//
//  Created by Rohan Jansen on 2017/08/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class CenterModalView: UIView {
    
    static func loadView() -> CenterModalView {
        return Bundle.loadView(fromNib: String(describing: CenterModalView.self), withType: CenterModalView.self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 10
    }
}

