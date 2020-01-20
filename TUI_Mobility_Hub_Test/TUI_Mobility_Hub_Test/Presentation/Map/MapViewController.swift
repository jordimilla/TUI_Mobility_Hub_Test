//
//  MapViewController.swift
//  TUI_Mobility_Hub_Test
//
//  Created by Jordi Milla on 20/01/2020.
//  Copyright © 2020 Jordi Milla Catalan. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    //MARK: IBOutlets
    let mapView = MKMapView()
    
    //MARK: Vars
    var viewModel: MapViewModel?
    
    //Mark: Static init
    static func instantiate(with params: MapParams) -> UIViewController? {
        let mapViewController = MapViewController()
        mapViewController.viewModel = MapViewModel(coordinates: params.coordinates)
        
        return mapViewController
    }
    
    //MARK: Lifecycle
    override func loadView() {
        super.loadView()
        configureView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindOperations()
        
        if let viewModel = viewModel {
            viewModel.requestAnnotations()
            viewModel.requestPathBetweenAnnotations()
        }
    }
    
    //MARK: Methods
    private func configureView(){
        view.addSubviewWithAutolayout(mapView)
        mapView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        mapView.layoutMargins = UIEdgeInsets(top: 40, left: 40, bottom: 40, right: 40)
        mapView.delegate = self
    }
    
    private func bindOperations(){
        
        guard let viewModel = viewModel else {
            
            let error = Errors.unknownError
            displayAlert(title: error.title().localized(), message: error.message().localized())
            return
        }
        
        viewModel.displayAnnotations = { [weak self] annotations in
            
            guard let self = self else {
                return
            }
            
            self.mapView.showAnnotations(annotations, animated: true)
        }
        
        viewModel.displayPath = { [weak self] path in
            
            guard let self = self else {
                return
            }
            
            self.mapView.addOverlay(path)
        }
    }
}

