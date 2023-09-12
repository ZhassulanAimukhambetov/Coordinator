//
//  RootCoordinator.swift
//  Coordinator
//
//  Created by iOS Developer (KolesaGroup) on 11.09.2023.
//

import Swinject

open class RootCoordinator: AssemblyCoordinator<Void> {
    public override init() {
        super.init()
        
        assembler = Assembler(assemblies)
    }
    
    public func removeAll() {
        if let container = assembler.resolver as? Container {
            container.removeAll()
        }
    }
}
