//
//  DTO+Content.swift
//  Koukuuki
//
//  Created by Madison Wass on 6/12/26.
//  (C) 2026 Capital City Electric Railway
//

import Vapor
import KoukuukiAPI

extension AircraftIntakeResponseDTO: @retroactive Content {}
extension AircraftIntakeCreateDTO: @retroactive Content {}
extension AircraftIntakeUpdateDTO: @retroactive Content {}
extension AircraftTypeCodeResponseDTO: @retroactive Content {}
extension AircraftTypeCodeCreateDTO: @retroactive Content {}
extension AircraftTypeCodeUpdateDTO: @retroactive Content {}
extension AircraftTypeCodeVariantResponseDTO: @retroactive Content {}
extension AircraftTypeCodeVariantCreateDTO: @retroactive Content {}
extension AircraftTypeCodeVariantUpdateDTO: @retroactive Content {}
extension AirlineResponseDTO: @retroactive Content {}
extension AirlineCreateDTO: @retroactive Content {}
extension AirlineUpdateDTO: @retroactive Content {}
extension AirportResponseDTO: @retroactive Content {}
extension AirportCreateDTO: @retroactive Content {}
extension AirportUpdateDTO: @retroactive Content {}
extension SpottingLocationResponseDTO: @retroactive Content {}
extension SpottingLocationCreateDTO: @retroactive Content {}
extension SpottingLocationUpdateDTO: @retroactive Content {}
