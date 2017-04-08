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
        if musicPlayer.isPlaying {
            musicPlayer.pause()
            sender.alpha = 0.3
        } else {
            musicPlayer.play()
            sender.alpha = 1
        }
    }
    
    var pokemons = [Pokemon]()
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
        parsePokemonCSV()
    }
    
    // MARK: - collection view
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonCollectionViewCell", for: indexPath) as? PokemonCollectionViewCell else {
            print("error: assigning dequeue rusable cell with reuse identifier PokemonCollectionViewCell failed!")
            return UICollectionViewCell()
        }
        
        let pokemon: Pokemon!
        
        if isInSearchMode {
            pokemon = filteredPokemons[indexPath.row]
        } else {
            pokemon = pokemons[indexPath.row]
        }
        
        cell.configureCell(pokemon)
        
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
    
    // Mark: - search bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if searchBar.text == nil || searchBar.text == "" {
            isInSearchMode = false
            view.endEditing(true)
            
        } else {
            isInSearchMode = true
            let searchKeyword = searchBar.text?.lowercased()
            filteredPokemons = pokemons.filter { pokemon in pokemon.name.lowercased().contains(searchKeyword!) }
        }
        collectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    // MARK: - helpers
    func parsePokemonCSV() {
        guard let path = Bundle.main.path(forResource: "pokemon", ofType: "csv") else {
            print("error: build pokemon.csv file path failed!")
            return
        }
        
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows {
                if let pokemonIdString = row["id"], let pokemonName = row["identifier"], let pokemonId = Int(pokemonIdString) {
                    let pokemon = Pokemon(name: pokemonName, id: pokemonId)
                    pokemons.append(pokemon)
                }
            }
        } catch let error as NSError {
            print(error.debugDescription)
        }
        
    }
    
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
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 105, height: 105)
//    }
    
}

