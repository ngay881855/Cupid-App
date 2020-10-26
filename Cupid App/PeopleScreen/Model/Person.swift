//
//  Person.swift
//  Cupid App
//
//  Created by Ngay Vong on 10/25/20.
//

import Foundation

struct ApiResponse: Decodable {
    var results: [Person]?
}

struct Person: Decodable {
    var gender: String?
    var name: Name?
    var location: Location?
    var dateOfBirth: DateOfBirth?
    var picture: Picture?
    
    enum CodingKeys: String, CodingKey {
        case gender
        case name
        case location
        case dateOfBirth = "dob"
        case picture
    }
    
    var fullName: String {
        let fullName = "\(name?.first ?? "") \(name?.last ?? "")"
        return fullName
    }
}

struct Name: Decodable {
    var first: String?
    var last: String?
}

struct Location: Decodable {
    var city: String?
    var state: String?
    var country: String?
    var coordinates: Coordinates?
}

struct Coordinates: Decodable {
    var latitude: String?
    var longitude: String?
}

struct DateOfBirth: Decodable {
    var date: String?
    var age: Int?
}

struct Picture: Decodable {
    var large: String?
    var medium: String?
    var thumbnail: String?
}
