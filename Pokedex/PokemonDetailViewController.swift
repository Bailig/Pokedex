//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Bailig Abhanar on 2017-04-08.
//  Copyright © 2017 Bailig Abhanar. All rights reserved.
//

import UIKit
import AVFoundation

class PokemonDetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
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
    
    var musicPlayer: AVAudioPlayer!
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func musicBtnPressed(_ sender: UIButton) {
        ToggleMusic.toggle(musicPlayer: musicPlayer, musicBtn: sender)
    }
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = pokemon.name
        mainImageView.image = UIImage(named: String(pokemon.id))
        
        pokemon.requestDetailData {
            self.descriptionLabel.text = self.pokemon.description
            self.typeLabel.text = self.pokemon.type
            self.defenseLabel.text = self.pokemon.defense
            self.heightLabel.text = self.pokemon.height
            self.pokemonIdLabel.text = String(self.pokemon.id)
            self.weightLabel.text = self.pokemon.weight
            self.attackLabel.text = self.pokemon.attack
            self.evolLabel.text = self.pokemon.evolText
            self.currentEvolImageView.image = UIImage(named: String(self.pokemon.currentEvolId))
            self.nextEvolImageView.image = UIImage(named: String(self.pokemon.nextEvolId))
        }
        
    }


}
