//
//  PhotosRequestParameters.swift
//  Mars Rovers
//
//  Created by Artem Klimov on 12/08/2019.
//  Copyright © 2019 artem. All rights reserved.
//

import Foundation

struct PhotosRequestParameters {
    let rover: String
    let camera: String?
    let date: String?
    var page: Int
}

