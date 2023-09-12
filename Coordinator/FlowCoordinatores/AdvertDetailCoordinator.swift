//
//  AdvertDetailCoordinatore.swift
//  Coordinator
//
//  Created by iOS Developer (KolesaGroup) on 11.09.2023.
//

import UIKit
import Swinject

final class AdvertDetailCoordinator: AssemblyCoordinator<AdvertDetailCoordinator.ChangeFlow> {
    enum ChangeFlow {
        case goTofavorites(NextAction)
        case close
        
        enum NextAction{
            case close
            case none
        }
    }
    
    override var assemblies: [Assembly] {
        [
            AdvertDetailAssembly()
        ]
    }
    
    private weak var navigation: UINavigationController?
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    override func start() {
        let vc = resolver.resolve(AdvertDetailVC.self)!
        
        vc.onTapButton = { [weak self, weak vc] _ in
            let coordinator = PaymentCoordinator(navigation: self!.navigation!)
            
            coordinator.onComplete = { result in
                switch result {
                case .close:
                    self?.onComplete?(.close)
                case .closeTo:
                    guard let vc else { return }
                    self?.navigation?.popToViewController(vc, animated: false)
                    self?.onComplete?(.goTofavorites(.none))
                case .none:
                    break
                }
            }
            
            self?.coordinate(to: coordinator)
            
        }
        
        navigation?.pushViewController(vc, animated: true)
    }
}



final class AdvertDetailAssembly: Assembly {
    func assemble(container: Container) {
        container.register(AdvertDetailVC.self) { _ in
            AdvertDetailVC()
        }
    }
}




final class AdvertDetailVC: UIViewController {
    var onTapButton: ((String) -> Void)?
    
    private let button: UIButton = .init(frame: .init(x: 200, y: 200, width: 200, height: 200))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        view.addSubview(button)
        
        button.backgroundColor = .red
        
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc private func didTapButton() {
        onTapButton?("Test")
    }
}
