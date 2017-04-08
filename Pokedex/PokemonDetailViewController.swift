//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Bailig Abhanar on 2017-04-08.
//  Copyright © 2017 Bailig Abhanar. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.text = pokemon.name
        }
    }
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var pokemonIdLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var evolLabel: UILabel!
    @IBOutlet weak var currentEvolImageView: UIImageView!
    @IBOutlet weak var nextEvolImageView: UIImageView!
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func musicBtnPressed(_ sender: Any) {
    }
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}
