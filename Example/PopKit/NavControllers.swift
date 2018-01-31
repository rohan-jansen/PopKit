import UIKit

class BurgerNavController: UINavigationController {
    
    static func fromStoryboard() -> BurgerNavController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: BurgerNavController.self)) as! BurgerNavController
    }
}

class OtherNavViewController: UINavigationController {
    
    static func fromStoryboard() -> OtherNavViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: OtherNavViewController.self)) as! OtherNavViewController
    }
}
