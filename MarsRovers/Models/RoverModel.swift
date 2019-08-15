//
//  File.swift
//  Mars Rovers
//
//  Created by Artem Klimov on 12/08/2019.
//  Copyright © 2019 artem. All rights reserved.
//

import Foundation

struct Rover {
    let name: String
    let cameras: [Cameras]
}



struct RoverCreator {
    static func create() -> [Rover] {
        return [
            Rover(name: "Curiosity", cameras: [.FHAZ, .RHAZ, .MAST, .CHEMCAM, .MAHLI, .MARDI, .NAVCAM]),
            Rover(name: "Opportunity", cameras: [.FHAZ, .RHAZ, .NAVCAM, .PANCAM, .MINITES]),
            Rover(name: "Spirit", cameras: [.FHAZ, .RHAZ, .NAVCAM, .PANCAM, .MINITES])
        ]
    }
}
