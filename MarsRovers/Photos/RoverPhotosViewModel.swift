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
    var requestParameters: PhotosRequestParameters! {get set}
    var provider: RoverPhotoProvider  {get set}
    var disposeBag: DisposeBag {get set}
    var photos: BehaviorRelay<[RoverPhoto]>  {get set}
    var router: RoverPhotosRouter? {get set}
    func didSelectImage(_ image: String)
    func loadMorePhotos()
    var imagesPerPage: Int {get}
}

class RoverPhotosViewModel: RoverPhotosViewModeling {

    var router: RoverPhotosRouter?
    var imagesPerPage = 25
    var currentPage = 1 {
        didSet {
            requestParameters.page = currentPage
        }
    }
    var morePhotosAvailable = true

    var requestParameters: PhotosRequestParameters! {
        didSet {
            getPhotos()
        }
    }
    internal var provider: RoverPhotoProvider
    internal var disposeBag = DisposeBag()
    var photos = BehaviorRelay<[RoverPhoto]>(value: [])
    
    init(provider: RoverPhotoProvider?) {
        self.provider = provider!
    }
    
    private func getPhotos() {
        provider.getPhotos(parameters: requestParameters).bind { (photos) in
            self.addNewPhotos(photos)
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
        router!.openPhotoViewer(image: image)
    }

}
