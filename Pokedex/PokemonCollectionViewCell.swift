//
//  PokemonCollectionViewCell.swift
//  Pokedex
//
//  Created by Bailig Abhanar on 2017-04-07.
//  Copyright © 2017 Bailig Abhanar. All rights reserved.
//

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var pokemon: Pokemon! {
        didSet {
            nameLabel.text = pokemon.name
            thumbImageView.image = UIImage(named: String(pokemon.id))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5
    }
}
