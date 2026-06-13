//
//  AirportController.swift
//  Koukuuki
//
//  Created by Madison Wass on 6/13/26.
//  (C) 2026 Capital City Electric Railway
//

import Fluent
import Vapor
import KoukuukiAPI

struct AirportController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let airports = routes.grouped("airports")
        
        airports.get(use: index)
        airports.post(use: create)
        airports.group(":airportID") { airport in
            airport.get(use: show)
            airport.patch(use: update)
            airport.delete(use: delete)
        }
        
        try airports.grouped(":airportID")
            .register(collection: SpottingLocationController())
    }
    
    @Sendable
    func index(req: Request) async throws -> [AirportResponseDTO] {
        try await Airport.query(on: req.db).all().map {
            try $0.toDTO()
        }
    }
    
    @Sendable
    func show(req: Request) async throws -> AirportResponseDTO {
        guard let airport = try await Airport.find(
            req.parameters.get("airportID", as: UUID.self), on: req.db
        ) else {
            throw Abort(.notFound)
        }
        
        return try airport.toDTO()
    }
    
    @Sendable
    func create(req: Request) async throws -> AirportResponseDTO {
        
        try AirportCreateDTO.validate(content: req)
        let dto = try req.content.decode(AirportCreateDTO.self)
        let airport = dto.toModel()
        try await airport.save(on: req.db)
        return try airport.toDTO()
    }
    
    @Sendable
    func update(req: Request) async throws -> AirportResponseDTO {
        guard let airport = try await Airport.find(
            req.parameters.get("airportID", as: UUID.self), on: req.db
        ) else {
            throw Abort(.notFound)
        }
        
        try AirportUpdateDTO.validate(content: req)
        let dto = try req.content.decode(AirportUpdateDTO.self)
        dto.apply(to: airport)
        
        try await airport.update(on: req.db)
        return try airport.toDTO()
    }
    
    @Sendable
    func delete(req: Request) async throws -> HTTPStatus {
        guard let airport = try await Airport.find(
            req.parameters.require("airportID", as: UUID.self), on: req.db
        ) else {
            throw Abort(.notFound)
        }
        
        try await airport.delete(on: req.db)
        return .noContent
    }
}
