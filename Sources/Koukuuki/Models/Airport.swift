//
//  Airport.swift
//  Koukuuki
//
//  Created by Madison Wass on 6/13/26.
//  (C) 2026 Capital City Electric Railway
//

import Fluent
import struct Foundation.UUID
import KoukuukiAPI

final class Airport: Model, @unchecked Sendable {
    static let schema = "airports"
    
    @ID(key: .id)
    var id: UUID?
    
    @OptionalField(key: "iata")
    var iata: String?
    
    @Field(key: "icao")
    var icao: String
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "alternate_names")
    var alternateNames: [String]
    
    @Field(key: "latitude")
    var latitude: Double
    
    @Field(key: "longitude")
    var longitude: Double
    
    @OptionalField(key: "remarks")
    var remarks: String?
    
    init() {
        
    }
    
    init(id: UUID? = nil, iata: String? = nil, icao: String, name: String, alternateNames: [String], latitude: Double, longitude: Double, remarks: String? = nil) {
        self.id = id
        self.iata = iata
        self.icao = icao
        self.name = name
        self.alternateNames = alternateNames
        self.latitude = latitude
        self.longitude = longitude
        self.remarks = remarks
    }
    
    func toDTO() throws -> AirportResponseDTO {
        .init(airportID: try requireID(),
              iata: self.iata,
              icao: self.icao,
              name: self.name,
              alternateNames: self.alternateNames,
              latitude: self.latitude,
              longitude: self.longitude,
              remarks: self.remarks)
    }
}

extension AirportCreateDTO {
    func toModel() -> Airport {
        .init(iata: self.iata,
              icao: self.icao,
              name: self.name,
              alternateNames: self.alternateNames,
              latitude: self.latitude,
              longitude: self.longitude,
              remarks: self.remarks)
    }
}

extension AirportUpdateDTO {
    func apply(to model: Airport) {
        if let iata {
            model.iata = iata
        }
        
        if let icao {
            model.icao = icao
        }
        
        if let name {
            model.name = name
        }
        
        if let alternateNames {
            model.alternateNames = alternateNames
        }
        
        if let latitude {
            model.latitude = latitude
        }
        
        if let longitude {
            model.longitude = longitude
        }
        
        if let remarks {
            model.remarks = remarks
        }
    }
}
