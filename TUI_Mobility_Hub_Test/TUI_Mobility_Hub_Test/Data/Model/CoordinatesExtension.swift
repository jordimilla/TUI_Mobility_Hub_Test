//
//  CoordinatesExtension.swift
//  TUI_Mobility_Hub_Test
//
//  Created by Jordi Milla on 20/01/2020.
//  Copyright © 2019 Jordi Milla Catalan. All rights reserved.
//

import MapKit

extension Coordinate: Mappable {
    
    func get2DCoordinate() -> CLLocationCoordinate2D? {
        
        guard let latitude = CLLocationDegrees(exactly: lat), let longitude = CLLocationDegrees(exactly: long) else {
            return nil
        }
        
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        //Check if the coordinate is a valid one
        guard CLLocationCoordinate2DIsValid(coordinate) else {
            return nil
        }
        
        return coordinate
        
    }
}
