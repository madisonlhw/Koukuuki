//
//  CreateAircraftIntake.swift
//  Koukuuki
//
//  Created by Madison Wass on 6/13/26.
//  (C) 2026 Capital City Electric Railway
//

import Fluent

struct CreateAircraftIntake: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema(AircraftIntake.schema)
            .id()
            .field("date", .date, .required)
            .field("registration", .string, .required)
            .field("airportCode", .string, .required)
            .create()
    }
    
    func revert(on database: any Database) async throws {
        try await database.schema(AircraftIntake.schema).delete()
    }
}
