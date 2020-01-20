//
//  MapViewModel.swift
//  TUI_Mobility_Hub_Test
//
//  Created by Jordi Milla on 20/01/2020.
//  Copyright © 2019 Jordi Milla Catalan. All rights reserved.
//

import Foundation
import MapKit

final class MapViewModel {
    
    //MARK: Vars
    private let coordinates: [Mappable]
    
    //MARK: MVVM Vars
    private var annotations: [MKAnnotation]? {
        didSet {
            guard let annotations = annotations else {
                return
            }
            
            self.displayAnnotations?(annotations)
        }
    }
    
    private var path: MKPolyline? {
        didSet {
            guard let path = path else {
                return
            }
            
            self.displayPath?(path)
        }
    }
    
    //MARK: MVVM Closures
    var displayAnnotations: (([MKAnnotation]) -> Void)?
    var displayPath: ((MKPolyline) -> Void)?
    
    //MARK: Lifecycle
    init(coordinates: [Mappable]) {
        self.coordinates = coordinates
    }
    
    //MARK: Methods
    func requestAnnotations() {
        
        var annotations = [MKAnnotation]()
        
        for coordinate in coordinates {
            if let mapCoordinate = coordinate.get2DCoordinate() {
                
                annotations.append(MapAnnotation(coordinate: mapCoordinate))
            }
        }
        
        self.annotations = annotations
    }
    
    func requestPathBetweenAnnotations() {
        
        var mapCoordinates = [CLLocationCoordinate2D]()
        
        for coordinate in coordinates {
            if let mapCoordinate = coordinate.get2DCoordinate() {
                mapCoordinates.append(mapCoordinate)
            }
        }
        
        let path = MKPolyline(coordinates: mapCoordinates, count: mapCoordinates.count)
        
        self.path = path
    }
}
