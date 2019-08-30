//
//  Swinject.swift
//  Mars Rovers
//
//  Created by Artem Klimov on 23/07/2019.
//  Copyright © 2019 artem. All rights reserved.
//

import Foundation

import Swinject
import SwinjectStoryboard
import SwinjectAutoregistration

extension SwinjectStoryboard {
    
    @objc class func setup() {
        
        defaultContainer.autoregister(RoversRouter.self, initializer: RoversRouter.init)
        
        defaultContainer.register(RoverViewModeling.self) { resolver in
            RoverViewModel(router: resolver.resolve(RoversRouter.self)!)
        }
        
        defaultContainer.storyboardInitCompleted(RoversViewController.self) { resolver, controller in
            let router = resolver.resolve(RoversRouter.self)!
            router.viewController = controller
            let viewModel = resolver.resolve(RoverViewModeling.self)
            controller.viewModel = viewModel
        }
        
    }
}
