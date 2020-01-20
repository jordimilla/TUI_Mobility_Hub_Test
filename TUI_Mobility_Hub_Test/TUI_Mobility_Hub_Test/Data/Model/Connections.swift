//
//  Connections.swift
//  TUI_Mobility_Hub_Test
//
//  Created by Jordi Milla on 20/01/2020.
//  Copyright © 2018 Jordi Milla Catalan. All rights reserved.
//

struct Connections: Decodable {
    let connections: [Connection]
}

struct Connection: Decodable {
    let from: String
    let to: String
    let price: Int
    
    let coordinates: Coordinates
}

struct Coordinates: Decodable {
    let from: Coordinate
    let to: Coordinate
}

struct Coordinate: Decodable {
    let lat: Double
    let long: Double
}
