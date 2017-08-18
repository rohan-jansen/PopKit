//
//  NotificationView.swift
//  PopKit_Example
//
//  Created by Rohan Jansen on 2017/08/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class NotificationView: UIView {
    @IBOutlet var notificationIcon: UIImageView!
    
    static func loadView() -> NotificationView {
        return Bundle.loadView(fromNib: String(describing: NotificationView.self), withType: NotificationView.self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        notificationIcon.tintColor = .white
    }
}
