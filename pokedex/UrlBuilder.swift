//
//  UrlBuilder.swift
//  pokedex
//
//  Created by Sara Henriksen on 24/01/2017.
//  Copyright © 2017 Alexander Steen. All rights reserved.
//

import Foundation

class UrlBuilder {
    private static let URL_BASE = "http://pokeapi.co"
    private static let URL_POKEMON = "/api/v1/pokemon/"
    
    static func getUrlForPokemon(pokedexId: Int) -> String {
        return "\(URL_BASE)\(URL_POKEMON)\(pokedexId)"
    }
    
    static func getUrlWithBasePrefix(url: String) -> String {
        return "\(URL_BASE)\(url)"
    }
}
