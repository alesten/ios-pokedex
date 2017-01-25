//
//  Pokemon.swift
//  pokedex
//
//  Created by Sara Henriksen on 19/01/2017.
//  Copyright © 2017 Alexander Steen. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionTxt: String!
    private var _pokemonURL: String!
    
    var name: String {
        
        return _name
    }
    
    var pokedexId: Int {
        
        return _pokedexId
    }
    
    init(name: String, pokedexId: Int) {
        
        self._name = name
        self._pokedexId = pokedexId
        
        self._pokemonURL = UrlBuilder.getUrlForPokemon(pokedexId: self.pokedexId)
        
    }
    
    func downloadPokemonDetails(completed: @escaping DownloadCompelte) {
        
        Alamofire.request(self._pokemonURL).responseJSON { (response) in
            if let dict = response.result.value as? Dictionary<String, Any> {
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String {
                    self._height = height
                }
                
                if let attack = dict["attack"] as? String {
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? String {
                    self._defense = "\(defense)"
                }
                
                print(self._weight)
                print(self._height)
                print(self._attack)
                print(self._defense)
                
                completed()
            }
        }
    }
}
