//
//  GraphNode.swift
//  TUI_Mobility_Hub_Test
//
//  Created by Jordi Milla on 20/01/2020.
//  Copyright © 2019 Jordi Milla Catalan. All rights reserved.
//

import GameplayKit

//Extends from GKGraphNode in order to use custom attributes (id and costs)
final class GraphNode: GKGraphNode {
    
    //To be used as a node identifier
    let id: String
    
    //To be used as a container for the connections cost
    var costs: [GKGraphNode: Float] = [:]
    
    init(id: String) {
        self.id = id
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.id = ""
        super.init()
    }
    
    override func cost(to node: GKGraphNode) -> Float {
        
        guard let cost = costs[node] else {
            return 0
        }
        
        return cost
    }
    
    func addConnection(to node: GKGraphNode, bidirectional: Bool, cost: Float) {
        
        addConnections(to: [node], bidirectional: bidirectional)
        
        costs[node] = cost
        
        if bidirectional, let node = node as? GraphNode {
            node.costs[self] = cost
        }
    }
}
