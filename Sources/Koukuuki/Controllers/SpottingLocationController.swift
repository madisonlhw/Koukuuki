//
//  SpottingLocationController.swift
//  Koukuuki
//
//  Created by Madison Wass on 6/13/26.
//  (C) 2026 Capital City Electric Railway
//

import Fluent
import Vapor
import KoukuukiAPI

struct SpottingLocationController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let locations = routes.grouped("locations")
        
        locations.get(use: index)
        locations.post(use: create)
        locations.group(":locationID") { location in
            location.get(use: show)
            location.patch(use: update)
            location.delete(use: delete)
        }
    }
    
    @Sendable
    func index(req: Request) async throws -> [SpottingLocationResponseDTO] {
        let airportID = try req.parameters.require("airportID", as: UUID.self)
        
        return try await SpottingLocation.query(on: req.db)
            .filter(\.$airport.$id == airportID)
            .all()
            .map {
                try $0.toDTO()
            }
    }
    
    @Sendable
    func show(req: Request) async throws -> SpottingLocationResponseDTO {
        let airportID = try req.parameters.require("airportID", as: UUID.self)
        let locationID = try req.parameters.require("locationID", as: UUID.self)
        
        guard let location = try await SpottingLocation.query(on: req.db)
            .filter(\.$id == locationID)
            .filter(\.$airport.$id == airportID)
            .first()
        else {
            throw Abort(.notFound)
        }
        
        return try location.toDTO()
    }
    
    @Sendable
    func create(req: Request) async throws -> SpottingLocationResponseDTO {
        let airportID = try req.parameters.require("airportID", as: UUID.self)
        try SpottingLocationCreateDTO.validate(content: req)
        let dto = try req.content.decode(SpottingLocationCreateDTO.self)
        let location = dto.toModel()
        
        location.$airport.id = airportID
        try await location.save(on: req.db)
        return try location.toDTO()
    }
    
    @Sendable
    func update(req: Request) async throws -> SpottingLocationResponseDTO {
        let airportID = try req.parameters.require("airportID", as: UUID.self)
        let locationID = try req.parameters.require("locationID", as: UUID.self)
        
        guard let location = try await SpottingLocation.query(on: req.db)
            .filter(\.$airport.$id == airportID)
            .filter(\.$id == locationID)
            .first()
        else {
            throw Abort(.notFound)
        }
        
        try SpottingLocationUpdateDTO.validate(content: req)
        let dto = try req.content.decode(SpottingLocationUpdateDTO.self)
        dto.apply(to: location)
        try await location.update(on: req.db)
        return try location.toDTO()
    }
    
    @Sendable
    func delete(req: Request) async throws -> HTTPStatus {
        let airportID = try req.parameters.require("airportID", as: UUID.self)
        let locationID = try req.parameters.require("locationID", as: UUID.self)
        
        guard let location = try await SpottingLocation.query(on: req.db)
            .filter(\.$id == locationID)
            .filter(\.$airport.$id == airportID)
            .first()
        else {
            throw Abort(.notFound)
        }
        
        try await location.delete(on: req.db)
        return .noContent
    }
}
