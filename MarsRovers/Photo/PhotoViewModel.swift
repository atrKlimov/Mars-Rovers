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
    var router: PhotoRouter?
    var imageURL: String

    init (imageURL: String) {
        self.imageURL = imageURL
    }
    
}
