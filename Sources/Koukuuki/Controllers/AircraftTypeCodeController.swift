//
//  AircraftTypeCodeController.swift
//  Koukuuki
//
//  Created by Madison Wass on 6/12/26.
//  (C) 2026 Capital City Electric Railway
//

import Fluent
import Vapor
import KoukuukiAPI

struct AircraftTypeCodeController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let typeCodes = routes.grouped("typecodes")
        
        typeCodes.get(use: index)
        typeCodes.post(use: create)
        typeCodes.group(":typeCodeID") { typeCode in
            typeCode.get(use: show)
            typeCode.patch(use: update)
            typeCode.delete(use: delete)
        }
    }
    
    @Sendable
    func index(req: Request) async throws -> [AircraftTypeCodeResponseDTO] {
        try await AircraftTypeCode.query(on: req.db).all().map {
            try $0.toDTO()
        }
    }
    
    @Sendable
    func show(req: Request) async throws -> AircraftTypeCodeResponseDTO {
        guard let typeCode = try await AircraftTypeCode.find(
            req.parameters.get("typeCodeID", as: UUID.self), on: req.db
        ) else {
            throw Abort(.notFound)
        }
        return try typeCode.toDTO()
    }
    
    @Sendable
    func create(req: Request) async throws -> AircraftTypeCodeResponseDTO {
        let dto = try req.content.decode(AircraftTypeCodeCreateDTO.self)
        let typeCode = dto.toModel()
        try await typeCode.save(on: req.db)
        return try typeCode.toDTO()
    }
    
    @Sendable
    func update(req: Request) async throws -> AircraftTypeCodeResponseDTO {
        guard let typeCode = try await AircraftTypeCode.find(
            req.parameters.get("typeCodeID", as: UUID.self), on: req.db
        ) else {
            throw Abort(.notFound)
        }
        
        let dto = try req.content.decode(AircraftTypeCodeUpdateDTO.self)
        dto.apply(to: typeCode)
        try await typeCode.update(on: req.db)
        return try typeCode.toDTO()
    }
    
    @Sendable
    func delete(req: Request) async throws -> HTTPStatus {
        guard let typeCode = try await AircraftTypeCode.find(
            req.parameters.require("typeCodeID", as: UUID.self), on: req.db
        ) else {
            throw Abort(.notFound)
        }
        
        try await typeCode.delete(on: req.db)
        return .noContent
    }
}
