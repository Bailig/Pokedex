//
//  MainViewController.swift
//  Pokedex
//
//  Created by Bailig Abhanar on 2017-04-07.
//  Copyright © 2017 Bailig Abhanar. All rights reserved.
//

import UIKit
import AVFoundation

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBAction func musicBtnPressed(_ sender: UIButton) {
        ToggleMusic.toggle(musicPlayer: musicPlayer, musicBtn: sender)
//        if musicPlayer.isPlaying {
//            musicPlayer.pause()
//            sender.alpha = 0.3
//        } else {
//            musicPlayer.play()
//            sender.alpha = 1
//        }
    }
    
    var pokemons: [Pokemon] = {
        guard let path = Bundle.main.path(forResource: "pokemon", ofType: "csv") else {
            print("error: build pokemon.csv file path failed!")
            return [Pokemon()]
        }
        
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            var pokemons = [Pokemon]()
            for row in rows {
                if let pokemonIdString = row["id"], let pokemonName = row["identifier"], let pokemonId = Int(pokemonIdString) {
                    let pokemon = Pokemon(name: pokemonName, id: pokemonId)
                    pokemons.append(pokemon)
                }
            }
            return pokemons
        } catch let error as NSError {
            print(error.debugDescription)
        }
        return [Pokemon()]
    }()
    
    var filteredPokemons = [Pokemon]()
    var isInSearchMode = false
    var musicPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        
        searchBar.returnKeyType = UIReturnKeyType.done
        
        initAudio()
    }
    
    // MARK: - collection view
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonCollectionViewCell", for: indexPath) as? PokemonCollectionViewCell else {
            print("error: assigning dequeue rusable cell with reuse identifier PokemonCollectionViewCell failed!")
            return UICollectionViewCell()
        }
        
        if isInSearchMode {
            cell.pokemon = filteredPokemons[indexPath.row]
        } else {
            cell.pokemon = pokemons[indexPath.row]
        }
        
        return cell
    }
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isInSearchMode {
            return filteredPokemons.count
        }
        return pokemons.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // MARK: - perforem and prepare segue way
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var pokemon: Pokemon!
        if isInSearchMode {
            pokemon = filteredPokemons[indexPath.row]
        } else {
            pokemon = pokemons[indexPath.row]
        }
        let sender: (pokemon: Pokemon, musicPlayer: AVAudioPlayer) = (pokemon: pokemon, musicPlayer: musicPlayer)
        performSegue(withIdentifier: "PokemonDetailViewController", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "PokemonDetailViewController", let pokemonDetailViewController = segue.destination as? PokemonDetailViewController, let sender = sender as? (pokemon: Pokemon, musicPlayer: AVAudioPlayer) else {
            print("error: prepare segue failed!")
            return
        }
        pokemonDetailViewController.pokemon = sender.pokemon
        pokemonDetailViewController.musicPlayer = sender.musicPlayer
    }
    
    // MARK: - search bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if searchBar.text == nil || searchBar.text == "" {
            isInSearchMode = false
            view.endEditing(true)
            
        } else {
            isInSearchMode = true
            let searchKeyword = searchBar.text?.lowercased()
            filteredPokemons = pokemons.filter { $0.name.lowercased().contains(searchKeyword!) }
        }
        collectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    // MARK: - helpers
    func initAudio() {
        guard let path = Bundle.main.path(forResource: "music", ofType: "mp3") else {
            print("error: build music.mp3 file path failed!")
            return
        }
        
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1  // infinite loop
            musicPlayer.play()
        } catch let error as NSError {
            print(error.debugDescription)
        }
    }
    
}

