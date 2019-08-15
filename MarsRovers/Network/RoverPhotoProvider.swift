//
//  RoverPhotoProvider.swift
//  MarsRovers
//
//  Created by Artem Klimov on 12/08/2019.
//  Copyright © 2019 Artem Klimov. All rights reserved.
//

import Moya
import RxSwift
import RxCocoa

struct RoverPhotoProvider {
    
    let provider = MoyaProvider<PhotosTarget>(plugins: [NetworkLoggerPlugin(verbose: true)])
    
    func getPhotos(parameters: PhotosRequestParameters) -> Observable<[RoverPhoto]> {
        return provider.rx
            .request(.getPhotos(parameters))
            .debug()
            .observeOn(MainScheduler.instance)
            .map(PhotosResponse.self)
            .map {$0.photos}
            .asObservable()
    }
    
}
