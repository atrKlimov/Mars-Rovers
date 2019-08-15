//
//  RoverPhotoRoute.swift
//  Mars Rovers
//
//  Created by Artem Klimov on 14/08/2019.
//  Copyright © 2019 artem. All rights reserved.
//

import Foundation

protocol RoverPhotosRoute {
    var openPhotoTransition: Transition { get }
    func openRoverPhotos(for request: PhotosRequestParameters)
}

extension RoverPhotosRoute where Self: RouterProtocol {
    
    var openPhotoTransition: Transition {
        return PushTransition()
    }
    
    func openRoverPhotos(for request: PhotosRequestParameters) {
        let roverPhotosViewController = RoverPhotosViewController.createFromStoryboard()
        roverPhotosViewController.viewModel?.requestParameters = request
        let openPhotoTransition = self.openPhotoTransition
        open(roverPhotosViewController, transition: openPhotoTransition)
    }
}
