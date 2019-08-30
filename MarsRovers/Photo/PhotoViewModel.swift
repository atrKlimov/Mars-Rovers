//
//  PhotoViewModel.swift
//  MarsRovers
//
//  Created by Artem Klimov on 13/08/2019.
//  Copyright © 2019 Artem Klimov. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Kingfisher

class PhotoViewModel {
    var router: PhotoRouter.Routes
    var imageURL: String?

    init (imageURL: String?, router: PhotoRouter) {
        self.imageURL = imageURL
        self.router = router
    }
    
}
