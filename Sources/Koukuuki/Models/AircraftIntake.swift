//
//  AircraftIntake.swift
//  Koukuuki
//
//  Created by Madison Wass on 6/13/26.
//  (C) 2026 Capital City Electric Railway
//

import Fluent
import Foundation
import KoukuukiAPI

final class AircraftIntake: Model, @unchecked Sendable {
    static let schema = "aircraft_intakes"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "date")
    var date: Date
    
    @Field(key: "registration")
    var registration: String
    
    @Field(key: "airportCode")
    var airportCode: String
    
    init() {
        
    }
    
    init(id: UUID? = nil, date: Date, registration: String, airportCode: String) {
        self.id = id
        self.date = date
        self.registration = registration
        self.airportCode = airportCode
    }
    
    func toDTO() throws -> AircraftIntakeResponseDTO {
        .init(aircraftIntakeID: try requireID(),
              date: self.date,
              registration: self.registration,
              airportCode: self.airportCode)
    }
}

extension AircraftIntakeCreateDTO {
    func toModel() -> AircraftIntake {
        .init(date: self.date,
              registration: self.registration,
              airportCode: self.airportCode)
    }
}

extension AircraftIntakeUpdateDTO {
    func apply(to model: AircraftIntake) {
        if let date {
            model.date = date
        }
        
        if let registration {
            model.registration = registration
        }
        
        if let airportCode {
            model.airportCode = airportCode
        }
    }
}
