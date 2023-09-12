//
//  FavoritesCoordinator.swift
//  Coordinator
//
//  Created by iOS Developer (KolesaGroup) on 11.09.2023.
//

import UIKit

final class FavoritesCoordinator: TabItemCoordinator {
    override func start() {
        let vc = UIViewController()
        vc.view.backgroundColor = .blue
        navigation?.pushViewController(vc, animated: true)
    }
}
