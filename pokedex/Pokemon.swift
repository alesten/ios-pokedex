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
    private var _nextEvolutionName: String!
    private var _nextEvolutionId: String!
    private var _nextEvolutionLevel: String!
    private var _pokemonURL: String!
    
    var name: String {
        
        return _name
    }
    
    var pokedexId: Int {
        
        return _pokedexId
    }
    
    var description: String {
        
        if _description == nil {
            
            _description = ""
        }
        return _description
    }
    
    var type: String {
        
        if _type == nil {
            
            _type = ""
        }
        return _type
    }
    
    var defense: String {
        
        if _defense == nil {
            
            _defense = ""
        }
        return _defense
    }
    
    var height: String {
        
        if _height == nil {
            
            _height = ""
        }
        return _height
    }
    
    var weight: String {
        
        if _weight == nil {
            
            _weight = ""
        }
        return _weight
    }
    
    var attack: String {
        
        if _attack == nil {
            
            _attack = ""
        }
        return _attack
    }
    
    var nextEvolutionTxt: String {
        
        if _nextEvolutionTxt == nil {
            
            _nextEvolutionTxt = ""
        }
        return _nextEvolutionTxt
    }
    
    var nextEvolutionName: String {
        
        if _nextEvolutionName == nil {
            
            _nextEvolutionName = ""
        }
        return _nextEvolutionName
    }
    
    var nextEvolutionId: String {
        
        if _nextEvolutionId == nil {
            
            _nextEvolutionId = ""
        }
        return _nextEvolutionId
    }
    
    var nextEvolutionLevel: String {
        
        if _nextEvolutionLevel == nil {
            
            _nextEvolutionLevel = ""
        }
        return _nextEvolutionLevel
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
                
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                
                if let types = dict["types"] as? [Dictionary<String, String>] , types.count > 0 {
                    
                    for type in types {
                        
                        if let name = type["name"] {
        
                            if self._type == nil || self._type == "" {
                                self._type = name.capitalized
                            } else {
                                self._type! += "/\(name.capitalized)"
                            }
                        }
                    }
                    
                } else {
                    
                    self._type = "None"
                }
                
                if let descArr = dict["descriptions"] as? [Dictionary<String, String>] , descArr.count > 0 {
                    
                    if let url = descArr[0]["resource_uri"] {
                        
                        let descURL = UrlBuilder.getUrlWithBasePrefix(url: url)
                        
                        Alamofire.request(descURL).responseJSON(completionHandler: { (response) in
                            
                            if let descDict = response.result.value as? Dictionary<String, Any> {
                                
                                if let description = descDict["description"] as? String {
                                    
                                    let newDescription = description.replacingOccurrences(of: "POKEMON", with: "Pokemon")
                                    
                                    self._description = newDescription
                                }
                            }
                            
                            completed()
                        })
                    }
                } else {
                    
                    self._description = "None"
                }
                
                if let evolutions = dict["evolutions"] as?  [Dictionary<String, Any>] , evolutions.count > 0 {
                    
                    if let nextEvo = evolutions[0]["to"] as? String , nextEvo.range(of: "mega") == nil {
                     
                        self._nextEvolutionName = nextEvo
                        
                        if let url = evolutions[0]["resource_uri"] as? String {
                            
                            let newString = url.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                            let nextEvoId = newString.replacingOccurrences(of: "/", with: "")
                            
                            self._nextEvolutionId = nextEvoId
                        }
                        
                        if let lvlExist = evolutions[0]["level"] {
                            
                            if let lvl = lvlExist as? Int {
                                self._nextEvolutionLevel = "\(lvl)"
                            }
                            
                        } else {
                            
                            self._nextEvolutionLevel = ""
                        }
                        
                    }
                    
                }
            }
            
            completed()
        }
    }
}
