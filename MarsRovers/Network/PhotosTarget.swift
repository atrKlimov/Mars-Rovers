//
//  PhotosResponse.swift
//  Mars Rovers
//
//  Created by Artem Klimov on 12/08/2019.
//  Copyright © 2019 artem. All rights reserved.


import Foundation
import Moya

enum PhotosTarget {
    
    static private let apiKey = "eVXenKK0Uk3QT6f5Qzk0vxW8OJCVaUybXXZlsruB"
    case getPhotos(_ parameters: PhotosRequestParameters)
    
}

extension PhotosTarget: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://api.nasa.gov/mars-photos/api/v1/")!
    }
    
    var path: String {
        switch self {
        case .getPhotos(let parameters):
            return "rovers/\(parameters.rover.lowercased())/photos"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var parameters: [String: Any] {
        switch self {
        case .getPhotos(let parameters):
            
            var requestParameters: [String: Any] = [
                "api_key": PhotosTarget.apiKey,
                "page": String(parameters.page)
            ]
            if let camera = parameters.camera {
                requestParameters["camera"] = camera.lowercased()
            }
            if let date = parameters.date {
                requestParameters["earth_date"] = date
            }
            return requestParameters
        }
    }
    
    var task: Task {
        switch self {
        case .getPhotos(_):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}



