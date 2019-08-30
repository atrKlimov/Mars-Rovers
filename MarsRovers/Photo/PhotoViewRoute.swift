//
//  PhotoViewRoute.swift
//  MarsRovers
//
//  Created by Artem Klimov on 13/08/2019.
//  Copyright © 2019 Artem Klimov. All rights reserved.
//

import UIKit

protocol PhotoViewRoute {
    var openPhotoTransition: Transition { get }
    func openPhotoViewer(image: String?)
}

extension PhotoViewRoute where Self: RouterProtocol {
    
    var openPhotoTransition: Transition {
        return PushTransition()
    }
    
    func openPhotoViewer(image: String?) {
        let builder = PhotoViewBuilder(image: image)
        open(builder.viewController, transition: openPhotoTransition)
    }
}
