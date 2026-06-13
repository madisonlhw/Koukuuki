//
//  CreateAirline.swift
//  Koukuuki
//
//  Created by Madison Wass on 6/13/26.
//  (C) 2026 Capital City Electric Railway
//

import Fluent

struct CreateAirline: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema(Airline.schema)
            .id()
            .field("iata", .string)
            .field("icao", .string, .required)
            .field("name", .string, .required)
            .field("callsign", .string)
            .field("country", .string, .required)
            .field("isGovOrMilitary", .bool, .required)
            .field("remarks", .string)
            .create()
    }
    
    func revert(on database: any Database) async throws {
        try await database.schema(Airline.schema).delete()
    }
}
