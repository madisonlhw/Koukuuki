//
//  CreateAircraftTypeCode.swift
//  Koukuuki
//
//  Created by Madison Wass on 6/12/26.
//  (C) 2026 Capital City Electric Railway
//

import Fluent

struct CreateAircraftTypeCode: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema(AircraftTypeCode.schema)
            .id()
            .field("designator", .string, .required)
            .field("manufacturer", .string, .required)
            .field("defaultModel", .string, .required)
            .unique(on: "designator")
            .create()
    }
    
    func revert(on database: any Database) async throws {
        try await database.schema(AircraftTypeCode.schema).delete()
    }
}
