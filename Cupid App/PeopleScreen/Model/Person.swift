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
    var phone: String?
    var cell: String?
    var picture: Picture?
    
    enum CodingKeys: String, CodingKey {
        case gender
        case name
        case location
        case dateOfBirth = "dob"
        case phone
        case cell
        case picture
    }
    
    var fullName: String {
        let fullName = "\(name?.first ?? "") \(name?.last ?? "")"
        return fullName
    }
    
    var address: String {
        let address = "\(location?.city ?? ""), \(location?.state ?? ""), \(location?.country ?? "")"
        return address
    }
    
    var age: String {
        let age = dateOfBirth?.age ?? 0
        let ageStr = age != 0 ? "\(age)" : ""
        return ageStr
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
