//
//  AssemblyCoordinator.swift
//  Coordinator
//
//  Created by iOS Developer (KolesaGroup) on 11.09.2023.
//

import Swinject

open class AssemblyCoordinator<ResultType>: BaseCoordinator<ResultType> {
    public var resolver: Resolver {
        assembler.resolver
    }
    
    var assembler: Assembler!
    
    open var assemblies: [Assembly] {
        []
    }
    
    open override func coordinate<T>(to coordinator: BaseCoordinator<T>) {
        if let coordinator = coordinator as? AssemblyCoordinator<T> {
            let childAssembler = Assembler(parentAssembler: assembler)
            childAssembler.apply(assemblies: coordinator.assemblies)
            coordinator.assembler = childAssembler
        }
        
        super.coordinate(to: coordinator)
    }
}
