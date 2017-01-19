//
//  PokeCell.swift
//  pokedex
//
//  Created by Sara Henriksen on 19/01/2017.
//  Copyright © 2017 Alexander Steen. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumpImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var pokemon: Pokemon!
    
    func configureCell(pokemon: Pokemon) {
        
        self.pokemon = pokemon
        
        nameLbl.text = self.pokemon.name.capitalized
        thumpImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
    }
    
}
