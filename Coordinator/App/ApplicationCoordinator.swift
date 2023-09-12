//
//  ApplicationCoordinator.swift
//  Coordinator
//
//  Created by iOS Developer (KolesaGroup) on 11.09.2023.
//

import UIKit
import Swinject

final class ApplicationAssembly: NSObject {
    static let assemblies: [Assembly] = [
        TabBarCoordinatorAssembly()
    ]
}

final class ApplicationCoordinator: RootCoordinator {
    static var shared = ApplicationCoordinator()
    private lazy var tabBarCoordinator = resolver.resolve(TabBarCoordinator.self)!
    
    override var assemblies: [Assembly] {
        ApplicationAssembly.assemblies
    }
    
    override func start() {
        if let window = UIApplication.shared.delegate?.window {
            tabBarCoordinator.window = window
            coordinate(to: tabBarCoordinator)
        }
    }
}
