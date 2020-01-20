//
//  MappableProtocol.swift
//  TUI_Mobility_Hub_Test
//
//  Created by Jordi Milla on 20/01/2020.
//  Copyright © 2019 Jordi Milla Catalan. All rights reserved.
//

//To be implemented by a dataset that needs to be drawn in MKMapView

import MapKit

protocol Mappable {
    func get2DCoordinate() -> CLLocationCoordinate2D?
}
