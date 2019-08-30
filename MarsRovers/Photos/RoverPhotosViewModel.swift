//
//  RoverPhotosViewModel.swift
//  Mars Rovers
//
//  Created by Artem Klimov on 14/08/2019.
//  Copyright © 2019 artem. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


protocol RoverPhotosViewModeling {
    var requestParameters: PhotosRequestParameters {get set}
    var provider: RoverPhotoProvider {get set}
    var disposeBag: DisposeBag {get set}
    var photos: BehaviorRelay<[RoverPhoto]> {get set}
    var router: RoverPhotosRouter.Routes {get set}
    func didSelectImage(_ image: String)
    func loadMorePhotos()
    var imagesPerPage: Int {get}
}

class RoverPhotosViewModel: RoverPhotosViewModeling {

    var router: RoverPhotosRouter.Routes
    var imagesPerPage = 25
    var morePhotosAvailable = true
    internal var provider: RoverPhotoProvider
    internal var disposeBag = DisposeBag()
    var photos = BehaviorRelay<[RoverPhoto]>(value: [])
    
    var requestParameters: PhotosRequestParameters
    
    var currentPage = 1 {
        didSet {
            requestParameters.page = currentPage
        }
    }
    
    init(parameters: PhotosRequestParameters, router: RoverPhotosRouter, provider: RoverPhotoProvider) {
        self.requestParameters = parameters
        self.router = router
        self.provider = provider
        getPhotos()
    }
    
    func getPhotos() {
        provider.getPhotos(parameters: requestParameters).bind {[weak self] (photos) in
            self?.addNewPhotos(photos)
        }.disposed(by: disposeBag)
        
    }
    
    open func loadMorePhotos() {
        if morePhotosAvailable {
            requestParameters.page += 1
        }
    }
    
    private func addNewPhotos(_ photos: [RoverPhoto]) {
        self.photos.accept(self.photos.value + photos)
    }
    
    internal func didSelectImage(_ image: String) {
        router.openPhotoViewer(image: image)
    }

}
