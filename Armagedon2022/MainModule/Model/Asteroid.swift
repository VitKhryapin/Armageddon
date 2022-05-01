//
//  Asteroid.swift
//  Armagedon2022
//
//  Created by Vitaly Khryapin on 26.04.2022.
//

import Foundation

class Asteroid {
    internal var name: String
    internal var diameterMax: Double
    internal var hazardous: Bool
    internal var sentry: Bool
    internal var absoluteMagnitude: Double
    internal var relativeVelocity: String
    
    init(name: String, diameterMax: Double, hazardous: Bool, sentry: Bool, absoluteMagnitude: Double, relativeVelocity: String) {
        self.name = name
        self.diameterMax = diameterMax
        self.hazardous = hazardous
        self.sentry = sentry
        self.absoluteMagnitude = absoluteMagnitude
        self.relativeVelocity = relativeVelocity
    }
}
