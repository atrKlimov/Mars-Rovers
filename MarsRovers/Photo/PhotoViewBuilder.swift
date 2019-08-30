//
//  PhotoViewBuilder.swift
//  MarsRovers
//
//  Created by Artem Klimov on 29/08/2019.
//  Copyright © 2019 Artem Klimov. All rights reserved.
//

import Foundation

class PhotoViewBuilder {
    
    let viewController: PhotoViewController
    let viewModel: PhotoViewModel
    let router: PhotoRouter
    
    init(image: String?) {
        let router = PhotoRouter()
        let viewModel = PhotoViewModel(imageURL: image, router: router)
        let viewController = PhotoViewController.createFromStoryboard()
        viewController.viewModel = viewModel
        router.viewController = viewController
        
        self.router = router
        self.viewModel = viewModel
        self.viewController = viewController
    }
}
