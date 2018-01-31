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
            transition.type = indexPath.row > 1 ? kCATransitionPush : kCATransitionMoveIn
            transition.subtype = indexPath.row > 1 ? kCATransitionFromLeft : kCATransitionFromRight
            transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
            view.window!.layer.add(transition, forKey: kCATransition)
            
            self.present(vc, animated: false, completion: nil)
        }
    }
}


