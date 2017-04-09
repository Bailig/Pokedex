//
//  UrlBuilder.swift
//  Pokedex
//
//  Created by Bailig Abhanar on 2017-04-08.
//  Copyright © 2017 Bailig Abhanar. All rights reserved.
//


struct UrlBuilder {
    private init () { }
    
    static let baseUrl = "http://pokeapi.co"
    
    static func pokemonRequestUrl(withId id: Int) -> String {
        return "\(baseUrl)/api/v1/pokemon/\(id)/"
    }
}
