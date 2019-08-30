//
//  RoverPhotosBuilder.swift
//  MarsRovers
//
//  Created by Artem Klimov on 29/08/2019.
//  Copyright © 2019 Artem Klimov. All rights reserved.
//

import Foundation


class RoverPhotosBuilder {
    
    let router: RoverPhotosRouter
    let viewController: RoverPhotosViewController
    let viewModel: RoverPhotosViewModel
    
    init(parameters: PhotosRequestParameters) {
        let router = RoverPhotosRouter()
        let provider = RoverPhotoProvider()
        let viewModel = RoverPhotosViewModel(parameters: parameters, router: router, provider: provider)
        let viewController = RoverPhotosViewController.createFromStoryboard()
        
        viewController.viewModel = viewModel
        router.viewController = viewController
        
        self.router = router
        self.viewModel = viewModel
        self.viewController = viewController
    }
    
    
    
}
