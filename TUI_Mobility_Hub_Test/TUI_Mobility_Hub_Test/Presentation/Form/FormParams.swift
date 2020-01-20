//
//  PlannerParams.swift
//  TUI_Mobility_Hub_Test
//
//  Created by Jordi Milla on 20/01/2020.
//  Copyright © 2018 Jordi Milla Catalan. All rights reserved.
//

import Foundation

class FormParams {
    
    func queue() -> OperationQueue {
        return OperationQueue()
    }
    
    func session() -> URLSession {
        return URLSession(configuration: .default)
    }
    
    func reachability() -> Reachability? {
        
        var reachability: Reachability?
        
        do {
            reachability = try Reachability() //Create object
            
            try reachability?.start()         //Start updates
            
        } catch {
            reachability = nil
        }
        
        return reachability
    }
}
