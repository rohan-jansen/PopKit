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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 10
    }
}
