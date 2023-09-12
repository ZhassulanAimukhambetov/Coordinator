//
//  TabBarCoordinatorAssembly.swift
//  Coordinator
//
//  Created by iOS Developer (KolesaGroup) on 11.09.2023.
//

import Swinject

final class TabBarCoordinatorAssembly: Assembly {
    public func assemble(container: Container) {
        container.register(TabBarCoordinator.self) { resolver in
            return TabBarCoordinator()
        }
        
        container.register(TabBarViewController.self) { resolver in
            return TabBarViewController()
        }
        
    }
}
