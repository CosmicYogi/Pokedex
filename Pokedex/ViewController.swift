//
//  ViewController.swift
//  Pokedex
//
//  Created by mitesh soni on 01/07/16.
//  Copyright © 2016 Mitesh Soni. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    var pokemons = [Pokemon]();
    @IBOutlet var collection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.delegate = self;
        collection.dataSource = self;
        parsePokemonCSV();
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
        return 718;
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokeCell", forIndexPath: indexPath) as? PokeCell{
            let poke = pokemons[indexPath.row];
            cell.configureCell(poke);
            return cell;
        } else{
            return UICollectionViewCell();
        }
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(105, 105)
    }
}

