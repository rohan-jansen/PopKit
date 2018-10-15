import UIKit
import PopKit

class DrawerViewController: UITableViewController {

    static func fromStoryboard() -> DrawerViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: DrawerViewController.self)) as! DrawerViewController
    }
    
    @IBAction func didTapMenu(_ sender: Any) {
        PopKit.dismiss()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 4 {
            PopKit.dismiss()
        } else {
            let vc = OtherNavViewController.fromStoryboard()
            vc.modalPresentationStyle = .overFullScreen
            
            var title = "Profile"
            switch indexPath.row {
            case 0:
                title = "Profile"
            case 1:
                title = "Support"
            case 2:
                title = "Buy"
            case 3:
                title = "About"
            default: break
            }
            if let containedVC = vc.viewControllers[0] as? OtherViewController {
                _ = containedVC.view
                containedVC.setup(title, indexPath.row)
            }
            
            let transition = CATransition()
            transition.duration = 0.5
            transition.type = convertToCATransitionType(indexPath.row > 1 ? CATransitionType.push.rawValue : CATransitionType.moveIn.rawValue)
            transition.subtype = convertToOptionalCATransitionSubtype(indexPath.row > 1 ? CATransitionSubtype.fromLeft.rawValue : CATransitionSubtype.fromRight.rawValue)
            transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
            view.window!.layer.add(transition, forKey: kCATransition)
            
            self.present(vc, animated: false, completion: nil)
        }
    }
}



// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToCATransitionType(_ input: String) -> CATransitionType {
	return CATransitionType(rawValue: input)
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToOptionalCATransitionSubtype(_ input: String?) -> CATransitionSubtype? {
	guard let input = input else { return nil }
	return CATransitionSubtype(rawValue: input)
}
