//
//  DTO+Content.swift
//  Koukuuki
//
//  Created by Madison Wass on 6/12/26.
//  (C) 2026 Capital City Electric Railway
//

import Vapor
import KoukuukiAPI

extension AircraftTypeCodeResponseDTO: @retroactive Content {}
extension AircraftTypeCodeCreateDTO: @retroactive Content {}
extension AircraftTypeCodeUpdateDTO: @retroactive Content {}
