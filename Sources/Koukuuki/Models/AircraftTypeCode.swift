//
//  AircraftTypeCode.swift
//  Koukuuki
//
//  Created by Madison Wass on 6/12/26.
//  (C) 2026 Capital City Electric Railway
//

import Fluent
import struct Foundation.UUID
import KoukuukiAPI

final class AircraftTypeCode: Model, @unchecked Sendable {
    static let schema = "aircraft_type_codes"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "designator")
    var designator: String
    
    @Field(key: "manufacturer")
    var manufacturer: String
    
    @Field(key: "defaultModel")
    var defaultModel: String
    
    @Children(for: \.$typeCode)
    var variants: [AircraftTypeCodeVariant]
    
    init() {
        
    }
    
    init(id: UUID? = nil, designator: String, manufacturer: String, defaultModel: String) {
        self.id = id
        self.designator = designator
        self.manufacturer = manufacturer
        self.defaultModel = defaultModel
    }
    
    func toDTO() throws -> AircraftTypeCodeResponseDTO {
        .init(aircraftTypeCodeID: try requireID(),
              designator: self.designator,
              manufacturer: self.manufacturer,
              defaultModel: self.defaultModel)
    }
}

extension AircraftTypeCodeCreateDTO {
    func toModel() -> AircraftTypeCode {
        .init(designator: designator,
              manufacturer: manufacturer,
              defaultModel: defaultModel)
    }
}

extension AircraftTypeCodeUpdateDTO {
    func apply(to model: AircraftTypeCode) {
        if let designator {
            model.designator = designator
        }
        
        if let manufacturer {
            model.manufacturer = manufacturer
        }
        
        if let defaultModel {
            model.defaultModel = defaultModel
        }
    }
}
