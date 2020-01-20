//
//  GraphProtocol.swift
//  TUI_Mobility_Hub_Test
//
//  Created by Jordi Milla on 20/01/2020.
//  Copyright © 2019 Jordi Milla Catalan. All rights reserved.
//

protocol Graphable {
    func getNodeIds() -> Set<String>
    func getConnections() -> [GraphConnection]
}
