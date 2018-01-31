import UIKit

class OtherViewController: UIViewController {
    
    var row = 0
    
    @IBOutlet var label: UILabel!
    
    static func fromStoryboard() -> OtherViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: OtherViewController.self)) as! OtherViewController
    }
    
    @IBAction func didTapClose(_ sender: Any) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = row > 1 ? kCATransitionPush : kCATransitionMoveIn
        transition.subtype = row > 1 ? kCATransitionFromRight : kCATransitionFromLeft
        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        self.dismiss(animated: false, completion: nil)
    }
    
    func setup(_ title: String, _ row: Int) {
        self.row = row
        self.navigationController?.title = title
        self.label.text = "\(title) Page"
    }
    
}
