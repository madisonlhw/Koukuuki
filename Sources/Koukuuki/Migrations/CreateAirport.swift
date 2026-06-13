//
//  CreateAirport.swift
//  Koukuuki
//
//  Created by Madison Wass on 6/13/26.
//  (C) 2026 Capital City Electric Railway
//

import Fluent

struct CreateAirport: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema(Airport.schema)
            .id()
            .field("iata", .string)
            .field("icao", .string, .required)
            .field("name", .string, .required)
            .field("alternate_names", .array(of: .string))
            .field("latitude", .double, .required)
            .field("longitude", .double, .required)
            .field("remarks", .string)
            .unique(on: "icao")
            .unique(on: "iata")
            .create()
    }
    
    func revert(on database: any Database) async throws {
        try await database.schema(Airport.schema).delete()
    }
}
