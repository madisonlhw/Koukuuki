//
//  CreateAircraftTypeCodeVariant.swift
//  Koukuuki
//
//  Created by Madison Wass on 6/12/26.
//  (C) 2026 Capital City Electric Railway
//

import Fluent

struct CreateAircraftTypeCodeVariant: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema(AircraftTypeCodeVariant.schema)
            .id()
            .field("aircraft_type_codes_id", .uuid, .required,
                   .references("aircraft_type_codes", "id"))
            .field("name", .string, .required)
            .create()
    }
    
    func revert(on database: any Database) async throws {
        try await database.schema(AircraftTypeCodeVariant.schema).delete()
    }
}
