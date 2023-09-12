//
//  PaymentCoordinator.swift
//  Coordinator
//
//  Created by iOS Developer (KolesaGroup) on 11.09.2023.
//

import UIKit
import Swinject

final class PaymentCoordinator: AssemblyCoordinator<PaymentCoordinator.ChangeFlow> {
    enum ChangeFlow {
        case none
        case close
        case closeTo
    }
    
    override var assemblies: [Assembly] {
        [PaymentAssembly()]
    }
    
    private weak var navigation: UINavigationController?
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    override func start() {
        let vc = resolver.resolve(PaymentVC.self)!
        
        vc.onTapButton = { [weak self] _ in
            self?.onComplete?(.closeTo)
        }
        
        navigation?.pushViewController(vc, animated: true)
    }
}


final class PaymentVC: UIViewController {
    var onTapButton: ((String) -> Void)?
    
    private let button: UIButton = .init(frame: .init(x: 200, y: 200, width: 200, height: 200))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(button)
        
        button.backgroundColor = .green
        
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc private func didTapButton() {
        onTapButton?("Test")
    }
}


final class PaymentAssembly: Assembly {
    func assemble(container: Container) {
        container.register(PaymentVC.self) { _ in
            PaymentVC()
        }
    }
}
