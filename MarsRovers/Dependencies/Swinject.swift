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
        
        defaultContainer.autoregister(RoverPhotosRouter.self, initializer: RoverPhotosRouter.init)
    
        defaultContainer.register(RoverPhotoProvider.self) { _ in
            RoverPhotoProvider()
        }
        
        
        defaultContainer.register(RoverPhotosViewModeling.self) { resolver in
            RoverPhotosViewModel(provider: resolver.resolve(RoverPhotoProvider.self)!)
        }
        
        defaultContainer.storyboardInitCompleted(RoversViewController.self) { resolver, controller in
            let router = resolver.resolve(RoversRouter.self)!
            router.viewController = controller
            let viewModel = RoverViewModel(router: router)
            controller.viewModel = viewModel
        }
        
        defaultContainer.storyboardInitCompleted(RoverPhotosViewController.self) { resolver, controller in
            let router = resolver.resolve(RoverPhotosRouter.self)!
            router.viewController = controller
            controller.viewModel = resolver.resolve(RoverPhotosViewModeling.self)
            controller.viewModel!.router = router
        }
        
        defaultContainer.storyboardInitCompleted(PhotoViewController.self) { resolver, controller in
            controller.viewModel = resolver.resolve(PhotoViewModel.self)
        }
        
    }
}
