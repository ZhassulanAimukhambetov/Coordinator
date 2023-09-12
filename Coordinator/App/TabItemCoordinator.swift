//
//  TabItemCoordinator.swift
//  Coordinator
//
//  Created by iOS Developer (KolesaGroup) on 11.09.2023.
//

import UIKit

class TabItemCoordinator: AssemblyCoordinator<Void> {
    var onTabChange: ((Tab) -> Void)?
    weak var navigation: UINavigationController?
    
    func resetToRoot(animated: Bool) {
        if let presented = navigation?.presentedViewController {
            presented.dismiss(animated: animated)
        }
        navigation?.popToRootViewController(animated: animated)
        cleanUpChildCoordinators()
    }
}

final class TabBarViewController: UITabBarController {
    var onSelectedTab: ((Int) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        
        tabBar.tintColor = .blue
    }
    
    func selectedTab(with index: Int) {
        selectedIndex = index
    }
}

extension TabBarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let newSelectedIndex = selectedIndex
        onSelectedTab?(newSelectedIndex)
    }
}


enum Tab: Int, CaseIterable {
    case home
    case favorites
    case postAdvert
    case chat
    case cabinet
}

protocol TabSwithcer {
    func switchTo(tab: Tab)
}
