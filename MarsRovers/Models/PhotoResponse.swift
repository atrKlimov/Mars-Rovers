//
//  PhotoResponse.swift
//  MarsRovers
//
//  Created by Artem Klimov on 12/08/2019.
//  Copyright © 2019 Artem Klimov. All rights reserved.
//

import Foundation

struct RoverPhoto: Codable {
    let photoUrl: String
    let createdAt: String
    
    private enum CodingKeys: String, CodingKey {
        case photoUrl = "img_src"
        case createdAt = "earth_date"
    }
}

struct PhotosResponse: Codable {
    let photos: [RoverPhoto]
}
