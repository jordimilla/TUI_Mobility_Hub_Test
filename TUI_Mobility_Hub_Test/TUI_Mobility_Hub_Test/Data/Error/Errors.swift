//
//  Errors.swift
//  TUI_Mobility_Hub_Test
//
//  Created by Jordi Milla on 20/01/2020.
//  Copyright © 2020 Jordi Milla Catalan. All rights reserved.
//

enum Errors: Error {
    case networkError
    case noInternetConnection
    case parsingError
    case tripUnavailable
    case emptyFields
    case unknownError
    case drawingError
    
    func title() -> String {
        return "error_title"
    }
    
    func message() -> String {
        switch self {
        case .networkError:
            return "error_message_network"
        case .noInternetConnection:
            return "error_message_no_internet_connection"
        case .parsingError:
            return "error_message_parsing_data"
        case .tripUnavailable:
            return "error_message_trip_unavailable"
        case .emptyFields:
            return "error_message_empty_fields"
        case .unknownError:
            return "error_message_unknown"
        case .drawingError:
            return "error_message_drawing"
        }
    }
}
