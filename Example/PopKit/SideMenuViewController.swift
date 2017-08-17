//
//  SideMenuViewController.swift
//  PopKit_Example
//
//  Created by Rohan Jansen on 2017/08/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class SideMenuViewController : UIViewController {
    
    static func fromStoryboard() -> SideMenuViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: SideMenuViewController.self)) as! SideMenuViewController
    }
    
    @IBOutlet var profilePictureView: UIImageView!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        profilePictureView.layer.borderColor = UIColor.white.cgColor
        profilePictureView.layer.borderWidth = 3
        profilePictureView.layer.cornerRadius = profilePictureView.frame.width / 2
        profilePictureView.clipsToBounds = true
    }
}
