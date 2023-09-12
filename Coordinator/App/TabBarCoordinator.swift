//
//  TabBarCoordinator.swift
//  Coordinator
//
//  Created by iOS Developer (KolesaGroup) on 11.09.2023.
//

import UIKit

final class TabBarCoordinator: AssemblyCoordinator<Void> {
    var homeCoordinator = HomeCoordinator()
    var favoritesCoordinator = FavoritesCoordinator()
    var postAdvertCoordinator = PostAdvertCoordinator()
    var chatCoordinator = ChatCoordinator()
    var cabinetCooedinator = CabinetCooedinator()
    
    weak var window: UIWindow?
    
    private lazy var tabNavigationControllers = [Tab: UINavigationController]()
    
    private weak var tabBarController: TabBarViewController?
    
    override func start() {
        let module = resolver.resolve(TabBarViewController.self)!
        
        self.tabBarController = module
        window?.rootViewController = module
        
        tabBarController?.onSelectedTab = { selectedTab in
            print("Выбран таб - ", selectedTab)
        }
        
        setupTabBarNavigationControllers()
        
        setupHome()
        setupFavorites()
        setupOthers()
        
        tabBarController?.selectedTab(with: 0)
    }
    
    func setupTabBarNavigationControllers() {
        var items: [Tab: UINavigationController] = [:]
        
        Tab.allCases.forEach { tab in
            items[tab] = UINavigationController()
        }
        
        tabNavigationControllers = items
    }
    
    
    private func setupHome() {
        guard let navigation = tabNavigationControllers[.home] else { return }
        homeCoordinator.navigation = navigation
        homeCoordinator.onTabChange = { [weak self] tab in
            switch tab {
            case .favorites:
                self?.tabBarController?.selectedTab(with: tab.rawValue)
            default:
                break
            }
        }
        
        let tabItem = UITabBarItem(title: "Home", image: nil, tag: 0)
        navigation.tabBarItem = tabItem
        
        coordinate(to: homeCoordinator)
        tabBarController?.addChild(navigation)

    }
    
    private func setupFavorites() {
        guard let navigation = tabNavigationControllers[.favorites] else { return }
        favoritesCoordinator.navigation = navigation
        
        let tabItem = UITabBarItem(title: "Favorites", image: nil, tag: 1)
        navigation.tabBarItem = tabItem
        
        coordinate(to: favoritesCoordinator)
        tabBarController?.addChild(navigation)
    }
    
    private func setupOthers() {
        coordinate(to: postAdvertCoordinator)
        coordinate(to: chatCoordinator)
        coordinate(to: cabinetCooedinator)
    }
}
