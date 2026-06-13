//
//  CreateSpottingLocation.swift
//  Koukuuki
//
//  Created by Madison Wass on 6/13/26.
//  (C) 2026 Capital City Electric Railway
//

import Fluent

struct CreateSpottingLocation: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema(SpottingLocation.schema)
            .id()
            .field("name", .string, .required)
            .field("latitude", .double, .required)
            .field("longitude", .double, .required)
            .field("is_open", .bool, .required)
            .field("remarks", .string)
            .field("airport_id", .uuid, .required, .references("airports", "id"))
            .create()
    }
    
    func revert(on database: any Database) async throws {
        try await database.schema(SpottingLocation.schema).delete()
    }
}
