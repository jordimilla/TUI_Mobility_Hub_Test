//
//  Endpoint.swift
//  TUI_Mobility_Hub_Test
//
//  Created by Jordi Milla on 20/01/2020.
//  Copyright © 2020 Jordi Milla Catalan. All rights reserved.
//

import UIKit

import Foundation

// Constants that are used more than once
struct APIConstants {
    fileprivate static let scheme: String = "https"
    fileprivate static let host: String = "raw.githubusercontent.com"
    fileprivate static let path: String = "/TuiMobilityHub/ios-code-challenge/master/connections.json"
}

struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]?
}

extension Endpoint {
    var url: URL? {
        var components = URLComponents()
        components.scheme = APIConstants.scheme
        components.host = APIConstants.host
        components.path = path
        components.queryItems = queryItems
        
        return components.url
    }
}

extension Endpoint {
    static func connections() -> Endpoint {
        
        return Endpoint(
            path: APIConstants.path,
            queryItems: nil)
    }
}
