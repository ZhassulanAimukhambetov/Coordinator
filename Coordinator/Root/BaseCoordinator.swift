//
//  BaseCoordinator.swift
//  Coordinator
//
//  Created by iOS Developer (KolesaGroup) on 11.09.2023.
//
import Foundation

public typealias Block<T> = (T) -> Void

open class BaseCoordinator<ResultType> {

    public var onComplete: Block<ResultType>?
    
    private let id = UUID()
    
    private var childCoordinators: [UUID: Any] = [:]
    
    public init() {}
    
    open func coordinate<T>(to coordinator: BaseCoordinator<T>) {
        store(coordinator: coordinator)
        
        let completion = coordinator.onComplete
        coordinator.onComplete = { [weak self, weak coordinator] value in
            completion?(value)
            
            if let coordinator {
                self?.free(coordinator: coordinator)
            }
        }
        
        coordinator.start()
    }
    
    open func start() {
        assertionFailure("Нужно переопределить метод")
    }
    
    public func cleanUpChildCoordinators() {
        childCoordinators.removeAll()
    }
    
    private func store<T>(coordinator: BaseCoordinator<T>) {
        childCoordinators[coordinator.id] = coordinator
    }
    
    private func free<T>(coordinator: BaseCoordinator<T>) {
        childCoordinators.removeValue(forKey: coordinator.id)
    }
}
