//
//  DTO+Validatable.swift
//  Koukuuki
//
//  Created by Madison Wass on 6/13/26.
//  (C) 2026 Capital City Electric Railway
//

import Vapor
import KoukuukiAPI

extension Validator where T == Double {
    static var latitudeValidator: Validator<Double> {
        .range(-90...90)
    }
    
    static var longitudeValidator: Validator<Double> {
        .range(-180...180)
    }
}

extension AircraftIntakeCreateDTO: @retroactive Validatable {
    public static func validations(_ validations: inout Validations) {
        validations.add("airportCode",
                        as: String.self,
                        is: .count(3...4) && .characterSet(.uppercaseLetters.union(.decimalDigits)))
    }
}

extension AircraftIntakeUpdateDTO: @retroactive Validatable {
    public static func validations(_ validations: inout Validations) {
        validations.add("airportCode",
                        as: String.self,
                        is: .count(3...4) && .characterSet(.uppercaseLetters.union(.decimalDigits)),
                        required: false)
    }
}

extension AircraftTypeCodeCreateDTO: @retroactive Validatable {
    public static func validations(_ validations: inout Validations) {
        validations.add("designator",
                        as: String.self,
                        is: .count(2...4) && .characterSet(.uppercaseLetters.union(.decimalDigits)))
    }
}

extension AircraftTypeCodeUpdateDTO: @retroactive Validatable {
    public static func validations(_ validations: inout Validations) {
        validations.add("designator",
                        as: String.self,
                        is: .count(2...4) && .characterSet(.uppercaseLetters.union(.decimalDigits)),
                        required: false)
    }
}

extension AirlineCreateDTO: @retroactive Validatable {
    public static func validations(_ validations: inout Validations) {
        validations.add("iata",
                        as: String.self,
                        is: .count(2...2) && .characterSet(.uppercaseLetters.union(.decimalDigits)),
                        required: false)
        
        validations.add("icao",
                        as: String.self,
                        is: .count(3...5) && .characterSet(.uppercaseLetters))
        
        validations.add("country",
                        as: String.self,
                        is: .count(2...2) && .characterSet(.uppercaseLetters))
    }
}

extension AirlineUpdateDTO: @retroactive Validatable {
    public static func validations(_ validations: inout Validations) {
        validations.add("iata",
                        as: String.self,
                        is: .count(2...2) && .characterSet(.uppercaseLetters.union(.decimalDigits)),
                        required: false)
        
        validations.add("icao",
                        as: String.self,
                        is: .count(3...5) && .characterSet(.uppercaseLetters),
                        required: false)
        
        validations.add("country",
                        as: String.self,
                        is: .count(2...2) && .characterSet(.uppercaseLetters),
                        required: false)
    }
}

extension AirportCreateDTO: @retroactive Validatable {
    public static func validations(_ validations: inout Validations) {
        validations.add("icao",
                        as: String.self,
                        is: .count(3...4) && .characterSet(.uppercaseLetters.union(.decimalDigits)))
        
        validations.add("iata",
                        as: String.self,
                        is: .count(3...3) && .characterSet(.uppercaseLetters),
                        required: false)
        
        validations.add("latitude",
                        as: Double.self,
                        is: .latitudeValidator)
        
        validations.add("longitude",
                        as: Double.self,
                        is: .longitudeValidator)
    }
}

extension AirportUpdateDTO: @retroactive Validatable {
    public static func validations(_ validations: inout Validations) {
        validations.add("icao",
                        as: String.self,
                        is: .count(3...4) && .characterSet(.uppercaseLetters.union(.decimalDigits)),
                        required: false)
        
        validations.add("iata",
                        as: String.self,
                        is: .count(3...3) && .characterSet(.uppercaseLetters),
                        required: false)
        
        validations.add("latitude",
                        as: Double.self,
                        is: .range(-90...90),
                        required: false)
        
        validations.add("longitude",
                        as: Double.self,
                        is: .range(-180...180),
                        required: false)
    }
}

extension SpottingLocationCreateDTO: @retroactive Validatable {
    public static func validations(_ validations: inout Validations) {
        validations.add("latitude",
                        as: Double.self,
                        is: .latitudeValidator)
        
        validations.add("longitude",
                        as: Double.self,
                        is: .longitudeValidator)
    }
}

extension SpottingLocationUpdateDTO: @retroactive Validatable {
    public static func validations(_ validations: inout Validations) {
        validations.add("latitude",
                        as: Double.self,
                        is: .latitudeValidator,
                        required: false)
        
        validations.add("longitude",
                        as: Double.self,
                        is: .longitudeValidator,
                        required: false)
    }
}
