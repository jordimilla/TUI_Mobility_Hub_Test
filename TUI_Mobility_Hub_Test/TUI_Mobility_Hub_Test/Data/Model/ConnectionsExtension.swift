//
//  ConnectionsExtension.swift
//  TUI_Mobility_Hub_Test
//
//  Created by Jordi Milla on 20/01/2020.
//  Copyright © 2019 Jordi Milla Catalan. All rights reserved.
//

extension Connections: Graphable {
    
    func getNodeIds() -> Set<String> {
        var nodeIds = Set<String>()
        
        connections.forEach({
            nodeIds.insert($0.from)
            nodeIds.insert($0.to)
        })
        
        return nodeIds
    }
    
    func getConnections() -> [GraphConnection] {
        
        var edges = [GraphConnection]()
        
        connections.forEach({
            
            let edge = GraphConnection(start: $0.from, end: $0.to, cost: Float($0.price))
            edges.append(edge)
        })
        
        return edges
    }
}
