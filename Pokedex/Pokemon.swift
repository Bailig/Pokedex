//
//  Pokemon.swift
//  Pokedex
//
//  Created by Bailig Abhanar on 2017-04-07.
//  Copyright © 2017 Bailig Abhanar. All rights reserved.
//

import Foundation

class Pokemon {
    
    fileprivate var _name: String! = ""
    fileprivate var _id: Int! = 0
    
    var name: String {
        return _name
    }
    
    var id: Int {
        return _id
    }
    
    convenience init(name: String, id: Int) {
        self.init()
        _name = name.capitalized
        _id = id
    }
    
}
