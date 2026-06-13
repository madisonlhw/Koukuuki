//
//  AirlineController.swift
//  Koukuuki
//
//  Created by Madison Wass on 6/13/26.
//  (C) 2026 Capital City Electric Railway
//

import Fluent
import Vapor
import KoukuukiAPI

struct AirlineController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let airlines = routes.grouped("airlines")
        
        airlines.get(use: index)
        airlines.post(use: create)
        airlines.group(":airlineID") { airline in
            airline.get(use: show)
            airline.patch(use: update)
            airline.delete(use: delete)
        }
    }
    
    @Sendable
    func index(req: Request) async throws -> [AirlineResponseDTO] {
        try await Airline.query(on: req.db).all().map {
            try $0.toDTO()
        }
    }
    
    @Sendable
    func show(req: Request) async throws -> AirlineResponseDTO {
        guard let airline = try await Airline.find(
            req.parameters.get("airlineID", as: UUID.self), on: req.db
        ) else {
            throw Abort(.notFound)
        }
        
        return try airline.toDTO()
    }
    
    @Sendable
    func create(req: Request) async throws -> AirlineResponseDTO {
        try AirlineCreateDTO.validate(content: req)
        let dto = try req.content.decode(AirlineCreateDTO.self)
        let airline = dto.toModel()
        
        try await airline.save(on: req.db)
        return try airline.toDTO()
    }
    
    @Sendable
    func update(req: Request) async throws -> AirlineResponseDTO {
        guard let airline = try await Airline.find(
            req.parameters.get("airlineID", as: UUID.self), on: req.db
        ) else {
            throw Abort(.notFound)
        }
        
        try AirlineUpdateDTO.validate(content: req)
        let dto = try req.content.decode(AirlineUpdateDTO.self)
        dto.apply(to: airline)
        
        try await airline.update(on: req.db)
        return try airline.toDTO()
    }
    
    @Sendable
    func delete(req: Request) async throws -> HTTPStatus {
        guard let airline = try await Airline.find(
            req.parameters.get("airlineID", as: UUID.self), on: req.db
        ) else {
            throw Abort(.notFound)
        }
        
        try await airline.delete(on: req.db)
        return .noContent
    }
}
