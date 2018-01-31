import UIKit
import PopKit

class MainViewController: UIViewController {
    
    var sideMenu: PopKit {
        return PopKitBuilder() {
            $0.constraints = [.edges(left: 0, right: nil, top: 0, bottom: 0), .width(Float(UIScreen.main.bounds.width*0.85))]
            $0.inAnimation = .bounceFromLeft(damping: 0.82, velocity: 2, animationOption: .curveEaseInOut)
            $0.outAnimation = .bounceFromRight(damping: 0.72, velocity: 2, animationOption: .curveEaseInOut)
            $0.backgroundEffect = .blurDark
            $0.popupViewController = BurgerNavController.fromStoryboard()
        }
    }
    
    @IBAction func didTapOpen(_ sender: Any) {
        sideMenu.show()
    }
}

