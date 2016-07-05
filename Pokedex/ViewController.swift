//
//  ViewController.swift
//  Pokedex
//
//  Created by mitesh soni on 01/07/16.
//  Copyright © 2016 Mitesh Soni. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate{

    var filteredPokemons = [Pokemon]();
    var pokemons = [Pokemon]();
    var isSearching = false;
    @IBOutlet var collection: UICollectionView!
    @IBOutlet var pokemonSearchBar: UISearchBar!
    var musicPlayer : AVAudioPlayer! 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.delegate = self;
        collection.dataSource = self;
        pokemonSearchBar.delegate = self;
        playAudio();
        parsePokemonCSV();
        pokemonSearchBar.returnKeyType = UIReturnKeyType.Done;
    }

    func playAudio() -> Void {
        let path = NSBundle.mainBundle().pathForResource("music", ofType: "mp3")
        print(path);
        do{
            musicPlayer = try AVAudioPlayer(contentsOfURL: NSURL(string: path!)!);
            musicPlayer.prepareToPlay();
            musicPlayer.numberOfLoops = -1; //because we want to play infinite times.
            musicPlayer.play();
            musicPlayer.stop(); //TEMPORARY, also remove it from function which change music item image.
        } catch let err as NSError{
            print(err.debugDescription);
        }
    }
    func parsePokemonCSV(){
        if let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv"){
            do{
                let csv = try CSV(contentsOfURL: path)
                let rows = csv.rows;
                print(rows);
                for row  in rows {
                    let pokeId = Int(row["id"]!)!
                    let pokeName = row["identifier"]!
                    let poke = Pokemon(name: pokeName, pokedexId: pokeId)
                    pokemons.append(poke);
                }
            } catch let err as NSError{
                print(err.debugDescription);
            }
        } else{
            print("incorrect path");
        }
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1;
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (isSearching){
            return filteredPokemons.count;
        }
        return pokemons.count;
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        var poke : Pokemon;
        
        if (isSearching){
            poke = filteredPokemons[indexPath.row];
        } else{
            poke = pokemons[indexPath.row];
        }
        performSegueWithIdentifier("pokemonDetail", sender: poke)
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokeCell", forIndexPath: indexPath) as? PokeCell{
            let poke : Pokemon;
            
            if (isSearching){
                poke = filteredPokemons[indexPath.row];
            } else {
                poke = pokemons[indexPath.row];
            }
            cell.configureCell(poke);
            return cell;
        } else{
            return UICollectionViewCell();
        }
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(105, 105)
    }
    @IBAction func musicButtonDown(sender: UIButton) {
        if (musicPlayer.playing == true){
            musicPlayer.stop();
            sender.alpha = 0.3;
        } else{
            musicPlayer.play();
            musicPlayer.stop(); // TEMPORARY, Also remove from playAudio() function.
            sender.alpha = 1;
        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true);
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchBar.text == nil || searchBar.text == ""){
            isSearching = false;
            view.endEditing(true);
            
        } else{
            isSearching = true;
            let searchStringInLower = searchBar.text?.lowercaseString;
            
            filteredPokemons = pokemons.filter({$0.name.rangeOfString(searchStringInLower!) != nil})
        }
        collection.reloadData();
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "pokemonDetail"{
            if let pokemonViewDetailViewController = segue.destinationViewController as? PokemonDetailVC{
                if let poke = sender as? Pokemon{
                    pokemonViewDetailViewController.pokemon = poke;
                }
            }
        }
    }
}

