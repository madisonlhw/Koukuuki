//
//  AircraftTypeCodeVariantController.swift
//  Koukuuki
//
//  Created by Madison Wass on 6/12/26.
//

import Fluent
import Vapor
import KoukuukiAPI

struct AircraftTypeCodeVariantController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let variants = routes.grouped("variants")
        
        variants.get(use: index)
        variants.post(use: create)
        variants.group(":variantID") { variant in
            variant.get(use: show)
            variant.patch(use: update)
            variant.delete(use: delete)
        }
    }
    
    @Sendable
    func index(req: Request) async throws -> [AircraftTypeCodeVariantResponseDTO] {
        let typeCodeID = try req.parameters.require("typeCodeID", as: UUID.self)
        
        return try await AircraftTypeCodeVariant.query(on: req.db)
            .filter(\.$typeCode.$id == typeCodeID)
            .all()
            .map {
                try $0.toDTO()
            }
    }
    
    @Sendable
    func show(req: Request) async throws -> AircraftTypeCodeVariantResponseDTO {
        let typeCodeID = try req.parameters.require("typeCodeID", as: UUID.self)
        let variantID = try req.parameters.require("variantID", as: UUID.self)
        
        guard let variant = try await AircraftTypeCodeVariant.query(on: req.db)
            .filter(\.$id == variantID)
            .filter(\.$typeCode.$id == typeCodeID)
            .first()
        else {
            throw Abort(.notFound)
        }
        
        return try variant.toDTO()
    }
    
    @Sendable
    func create(req: Request) async throws -> AircraftTypeCodeVariantResponseDTO {
        let typeCodeID = try req.parameters.require("typeCodeID", as: UUID.self)
        let dto = try req.content.decode(AircraftTypeCodeVariantCreateDTO.self)
        let variant = dto.toModel()
        
        variant.$typeCode.id = typeCodeID
        try await variant.save(on: req.db)
        return try variant.toDTO()
    }
    
    @Sendable
    func update(req: Request) async throws -> AircraftTypeCodeVariantResponseDTO {
        let typeCodeID = try req.parameters.require("typeCodeID", as: UUID.self)
        let variantID = try req.parameters.require("variantID", as: UUID.self)
        
        guard let variant = try await AircraftTypeCodeVariant.query(on: req.db)
            .filter(\.$typeCode.$id == typeCodeID)
            .filter(\.$id == variantID)
            .first() else {
            throw Abort(.notFound)
        }
        
        let dto = try req.content.decode(AircraftTypeCodeVariantUpdateDTO.self)
        dto.apply(to: variant)
        try await variant.update(on: req.db)
        return try variant.toDTO()
    }
    
    @Sendable
    func delete(req: Request) async throws -> HTTPStatus {
        let typeCodeID = try req.parameters.require("typeCodeID", as: UUID.self)
        let variantID = try req.parameters.require("variantID", as: UUID.self)
        
        guard let variant = try await AircraftTypeCodeVariant.query(on: req.db)
            .filter(\.$typeCode.$id == typeCodeID)
            .filter(\.$id == variantID)
            .first() else {
            throw Abort(.notFound)
        }
        
        try await variant.delete(on: req.db)
        return .noContent
    }
}
