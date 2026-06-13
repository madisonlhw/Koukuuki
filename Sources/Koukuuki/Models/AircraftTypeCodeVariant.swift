//
//  AircraftTypeCodeVariant.swift
//  Koukuuki
//
//  Created by Madison Wass on 6/12/26.
//  (C) 2026 Capital City Electric Railway
//

import Fluent
import struct Foundation.UUID
import KoukuukiAPI

final class AircraftTypeCodeVariant: Model, @unchecked Sendable {
    static let schema = "aircraft_type_code_variants"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "aircraft_type_codes_id")
    var typeCode: AircraftTypeCode
    
    @Field(key: "name")
    var name: String
    
    init() {
        
    }
    
    init(id: UUID? = nil, name: String) {
        self.id = id
        self.name = name
    }
    
    func toDTO() throws -> AircraftTypeCodeVariantResponseDTO {
        .init(variantID: try requireID(),
              aircraftTypeCodeID: self.$typeCode.id,
              name: self.name)
    }
}

extension AircraftTypeCodeVariantCreateDTO {
    func toModel() -> AircraftTypeCodeVariant {
        .init(
            name: self.name
        )
    }
}

extension AircraftTypeCodeVariantUpdateDTO {
    func apply(to model: AircraftTypeCodeVariant) {
        if let name {
            model.name = name
        }
    }
}
