//
//  AircraftIntakeController.swift
//  Koukuuki
//
//  Created by Madison Wass on 6/13/26.
//  (C) 2026 Capital City Electric Railway
//

import Fluent
import Vapor
import KoukuukiAPI

struct AircraftIntakeController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let intake = routes.grouped("intake")
        
        intake.get(use: index)
        intake.post(use: create)
        intake.group(":aircraftIntakeID") { intakeRecord in
            intakeRecord.get(use: show)
            intakeRecord.patch(use: update)
            intakeRecord.delete(use: delete)
        }
    }
    
    @Sendable
    func index(req: Request) async throws -> [AircraftIntakeResponseDTO] {
        try await AircraftIntake.query(on: req.db).all().map {
            try $0.toDTO()
        }
    }
    
    @Sendable
    func show(req: Request) async throws -> AircraftIntakeResponseDTO {
        guard let intake = try await AircraftIntake.find(
            req.parameters.get("aircraftIntakeID", as: UUID.self), on: req.db
        ) else {
            throw Abort(.notFound)
        }
        
        return try intake.toDTO()
    }
    
    @Sendable
    func create(req: Request) async throws -> AircraftIntakeResponseDTO {
        try AircraftIntakeCreateDTO.validate(content: req)
        let dto = try req.content.decode(AircraftIntakeCreateDTO.self)
        let intake = dto.toModel()
        
        try await intake.save(on: req.db)
        return try intake.toDTO()
    }
    
    @Sendable
    func update(req: Request) async throws -> AircraftIntakeResponseDTO {
        guard let intake = try await AircraftIntake.find(
            req.parameters.get("aircraftIntakeID", as: UUID.self), on: req.db
        ) else {
            throw Abort(.notFound)
        }
        
        try AircraftIntakeUpdateDTO.validate(content: req)
        let dto = try req.content.decode(AircraftIntakeUpdateDTO.self)
        dto.apply(to: intake)
        
        try await intake.update(on: req.db)
        return try intake.toDTO()
    }
    
    @Sendable
    func delete(req: Request) async throws -> HTTPStatus {
        guard let intake = try await AircraftIntake.find(
            req.parameters.get("aircraftIntakeID", as: UUID.self), on: req.db
        ) else {
            throw Abort(.notFound)
        }
        
        try await intake.delete(on: req.db)
        return .noContent
    }
}
