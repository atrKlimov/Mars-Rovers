//
//  RoversViewModel.swift
//  Mars Rovers
//
//  Created by Artem Klimov on 13/08/2019.
//  Copyright © 2019 artem. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa



class RoverViewModel {
    var roversData: Observable<[Rover]>
    var rover = PublishSubject<Rover>()
    private let router: RoversRouter.Routes
    
    var roverText = BehaviorRelay<String>(value: "")
    var cameraText = BehaviorRelay<String>(value: "")
    var dateText = BehaviorRelay<String>(value: "")
    
    var isParametersValid: Observable<Bool> {
        return Observable.combineLatest(roverText.asObservable(), cameraText.asObservable(), dateText.asObservable()) { rover, camera, date in
            !rover.isEmpty && !camera.isEmpty && !date.isEmpty
        }
    }
    
    init(router: RoversRouter.Routes) {
        self.router = router
        self.roversData = Observable.of(RoverCreator.create())
    }
    
    func openSelectedRover() {
        let request = PhotosRequestParameters(rover: roverText.value, camera: cameraText.value, date: dateText.value, page: 1)
        router.openRoverPhotos(for: request)
    }
    
    
}
