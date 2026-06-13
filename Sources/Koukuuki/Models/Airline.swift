//
//  Airline.swift
//  Koukuuki
//
//  Created by Madison Wass on 6/13/26.
//  (C) 2026 Capital City Electric Railway
//

import Fluent
import struct Foundation.UUID
import KoukuukiAPI

final class Airline: Model, @unchecked Sendable {
    static let schema = "airlines"
    
    @ID(key: .id)
    var id: UUID?
    
    @OptionalField(key: "iata")
    var iata: String?
    
    @Field(key: "icao")
    var icao: String
    
    @Field(key: "name")
    var name: String
    
    @OptionalField(key: "callsign")
    var callsign: String?
    
    @Field(key: "country")
    var country: String
    
    @Field(key: "isGovOrMilitary")
    var isGovOrMilitary: Bool
    
    @OptionalField(key: "remarks")
    var remarks: String?
    
    init() {
        
    }
    
    init(id: UUID? = nil, iata: String? = nil, icao: String, name: String, callsign: String? = nil, country: String, isGovOrMilitary: Bool, remarks: String? = nil) {
        self.id = id
        self.iata = iata
        self.icao = icao
        self.name = name
        self.callsign = callsign
        self.country = country
        self.isGovOrMilitary = isGovOrMilitary
        self.remarks = remarks
    }
    
    func toDTO() throws -> AirlineResponseDTO {
        .init(airlineID: try requireID(),
              iata: self.iata,
              icao: self.icao,
              name: self.name,
              callsign: self.callsign,
              country: self.country,
              isGovOrMilitary: self.isGovOrMilitary,
              remarks: self.remarks)
    }
}

extension AirlineCreateDTO {
    func toModel() -> Airline {
        .init(iata: self.iata,
              icao: self.icao,
              name: self.name,
              callsign: self.callsign,
              country: self.country,
              isGovOrMilitary: self.isGovOrMilitary,
              remarks: self.remarks)
    }
}

extension AirlineUpdateDTO {
    func apply(to model: Airline) {
        if let iata {
            model.iata = iata
        }
        
        if let icao {
            model.icao = icao
        }
        
        if let name {
            model.name = name
        }
        
        if let callsign {
            model.callsign = callsign
        }
        
        if let country {
            model.country = country
        }
        
        if let isGovOrMilitary {
            model.isGovOrMilitary = isGovOrMilitary
        }
        
        if let remarks {
            model.remarks = remarks
        }
    }
}
