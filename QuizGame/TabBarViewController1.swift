
import UIKit

class TabBarViewController1: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // primjer hijerarhije viewControllera
        // TabBarViewController sadrzi 2 UIViewControllera: UINavigationController i SettingsViewController
        // UINavigationController na svom stogu sadrzi ReviewsViewController
        
        let vc = MyViewController()
        let nvc = UINavigationController(rootViewController: vc)
        
        // UIViewControlleri imaju property UINavigationItem koji nije UIView, vec objekt koji sadrzi podatke koje UINavigationController koristi pri iscrtavanju svog UINavigationBar-a
        // npr property 'title' UINavigationBar-a od ovog ReviewsViewController sadrzi naslov koji ce se ispisati u navigationBaru kada se ReviewsViewController pusha na vrh stoga UINavigationControllera (kada se prikaze na ekranu)
        vc.navigationItem.title = "Title"
        
        // UIViewControlleri imaju property UITabBarItem koji sadrzi podatke koje koristi UITabBarController
        // UITabBarController koristi tabBarItem objekt da bi iscrtao tab za svaki viewController u svom arrayu viewControllera,
        nvc.tabBarItem = UITabBarItem(title: "Home", image: nil, tag: 0)
        
        //let vc2 = SettingsViewController()
        //vc2.tabBarItem = UITabBarItem(title: "Settings", image: nil, tag: 0)
        
        self.viewControllers = [nvc]
    }
}
