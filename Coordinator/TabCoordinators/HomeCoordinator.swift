//
//  HomeCoordinator.swift
//  Coordinator
//
//  Created by iOS Developer (KolesaGroup) on 11.09.2023.
//

import Foundation
import Swinject

final class HomeCoordinator: TabItemCoordinator {
    override func start() {
        let vc = ViewController()
        
        vc.onChangeFlow = { [weak self] indexFlow in
            guard let self else { return }
            let coordinator = AdvertDetailCoordinator(navigation: self.navigation!)
            
            coordinator.onComplete = { [weak self] result in
                switch result {
                case .goTofavorites(let flowChangeClosing):
                    if flowChangeClosing == .close {
                        self?.navigation?.popToRootViewController(animated: false)
                    }
                    
                    self?.onTabChange?(.favorites)
                case .close:
                    self?.navigation?.popToRootViewController(animated: false)
                }
                
            }
            self.coordinate(to: coordinator)
        }
        
        navigation?.setViewControllers([vc], animated: false)
    }
}
