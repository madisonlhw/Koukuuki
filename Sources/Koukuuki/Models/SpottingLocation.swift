//
//  SpottingLocation.swift
//  Koukuuki
//
//  Created by Madison Wass on 6/13/26.
//  (C) 2026 Capital City Electric Railway
//

import Fluent
import struct Foundation.UUID
import KoukuukiAPI

final class SpottingLocation: Model, @unchecked Sendable {
    static let schema = "spotting_locations"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "latitude")
    var latitude: Double
    
    @Field(key: "longitude")
    var longitude: Double
    
    @Field(key: "is_open")
    var isOpen: Bool
    
    @OptionalField(key: "remarks")
    var remarks: String?
    
    @Parent(key: "airport_id")
    var airport: Airport

    init() {
        
    }
    
    init(id: UUID? = nil, name: String, latitude: Double, longitude: Double, isOpen: Bool, remarks: String? = nil) {
        self.id = id
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.isOpen = isOpen
        self.remarks = remarks
    }
    
    func toDTO() throws -> SpottingLocationResponseDTO {
        .init(locationID: try requireID(),
              airportID: self.$airport.id,
              name: self.name,
              latitude: self.latitude,
              longitude: self.longitude,
              isOpen: self.isOpen,
              remarks: self.remarks)
    }
}

extension SpottingLocationCreateDTO {
    func toModel() -> SpottingLocation {
        .init(name: self.name,
              latitude: self.latitude,
              longitude: self.longitude,
              isOpen: self.isOpen,
              remarks: self.remarks)
    }
}

extension SpottingLocationUpdateDTO {
    func apply(to model: SpottingLocation) {
        if let name {
            model.name = name
        }
        
        if let latitude {
            model.latitude = latitude
        }
        
        if let longitude {
            model.longitude = longitude
        }
        
        if let isOpen {
            model.isOpen = isOpen
        }
        
        if let remarks {
            model.remarks = remarks
        }
    }
}
