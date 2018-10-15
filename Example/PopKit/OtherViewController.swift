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
        transition.type = convertToCATransitionType(row > 1 ? CATransitionType.push.rawValue : CATransitionType.moveIn.rawValue)
        transition.subtype = convertToOptionalCATransitionSubtype(row > 1 ? CATransitionSubtype.fromRight.rawValue : CATransitionSubtype.fromLeft.rawValue)
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        self.dismiss(animated: false, completion: nil)
    }
    
    func setup(_ title: String, _ row: Int) {
        self.row = row
        self.navigationController?.title = title
        self.label.text = "\(title) Page"
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
