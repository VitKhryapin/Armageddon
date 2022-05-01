//
//  DataModel.swift
//  Armagedon2022
//
//  Created by Vitaly Khryapin on 26.04.2022.
//

import Foundation


internal struct ClosestAsteroidsRoot : Codable {
    let links: ClosestAsteroidsLinks
    let elementCount: Int
    let nearEarthObjects: [String: [NearEarthObject]]
    
    enum CodingKeys: String, CodingKey {
        case links
        case elementCount = "element_count"
        case nearEarthObjects = "near_earth_objects"
    }
}
    
internal struct ClosestAsteroidsLinks : Codable {
    let next: String
    let prev: String
    let linksSelf: String
    
    enum CodingKeys: String, CodingKey {
        case next
        case prev
        case linksSelf = "self"
    }
}

internal struct NearEarthObject : Codable {
    let links: NearEarthObjectLinks
    let id: String
    let neoReferenceID: String
    let name: String
    let nasaJplURL: String
    let absoluteMagnitudeH: Double
    let estimatedDiameter: EstimatedDiameter
    let isPotentiallyHazardousAsteroid: Bool
    let closeApproachData: [CloseApproachDatum]
    let isSentryObject: Bool
    
    enum CodingKeys: String, CodingKey {
        case links
        case id
        case neoReferenceID = "neo_reference_id"
        case name
        case nasaJplURL = "nasa_jpl_url"
        case absoluteMagnitudeH = "absolute_magnitude_h"
        case estimatedDiameter = "estimated_diameter"
        case isPotentiallyHazardousAsteroid = "is_potentially_hazardous_asteroid"
        case closeApproachData = "close_approach_data"
        case isSentryObject = "is_sentry_object"
    }
}

internal struct CloseApproachDatum : Codable {
    let closeApproachDate: String
    let closeApproachDateFull: String?
    let epochDateCloseApproach: Int
    let relativeVelocity: RelativeVelocity
    let missDistance: MissDistance
    let orbitingBody: OrbitingBody
    
    enum CodingKeys: String, CodingKey {
        case closeApproachDate = "close_approach_date"
        case closeApproachDateFull = "close_approach_date_full"
        case epochDateCloseApproach = "epoch_date_close_approach"
        case relativeVelocity = "relative_velocity"
        case missDistance = "miss_distance"
        case orbitingBody = "orbiting_body"
    }
}

internal struct MissDistance : Codable {
    let astronomical: String
    let lunar: String
    let kilometers: String
    let miles: String
}

internal enum OrbitingBody : String, Codable {
    case earth = "Earth"
}

internal struct RelativeVelocity : Codable {
    let kilometersPerSecond: String
    let kilometersPerHour: String
    let milesPerHour: String
    
    enum CodingKeys: String, CodingKey {
        case kilometersPerSecond = "kilometers_per_second"
        case kilometersPerHour = "kilometers_per_hour"
        case milesPerHour = "miles_per_hour"
    }
}

internal struct EstimatedDiameter: Codable {
    let kilometers: Feet
    let meters: Feet
    let miles: Feet
    let feet: Feet
}

internal struct Feet : Codable {
    let estimatedDiameterMin: Double
    let estimatedDiameterMax: Double
    
    enum CodingKeys: String, CodingKey {
        case estimatedDiameterMin = "estimated_diameter_min"
        case estimatedDiameterMax = "estimated_diameter_max"
    }
}

internal struct NearEarthObjectLinks : Codable {
    let linksSelf: String
    
    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
    }
}
