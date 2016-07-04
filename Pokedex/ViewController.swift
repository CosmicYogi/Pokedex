//
//  ViewController.swift
//  Pokedex
//
//  Created by mitesh soni on 01/07/16.
//  Copyright © 2016 Mitesh Soni. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    var pokemons = [Pokemon]();
    @IBOutlet var collection: UICollectionView!
    var musicPlayer : AVAudioPlayer! 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.delegate = self;
        collection.dataSource = self;
        playAudio();
        parsePokemonCSV();
    }

    func playAudio() -> Void {
        let path = NSBundle.mainBundle().pathForResource("music", ofType: "mp3")
        print(path);
        do{
            musicPlayer = try AVAudioPlayer(contentsOfURL: NSURL(string: path!)!);
            musicPlayer.prepareToPlay();
            musicPlayer.numberOfLoops = -1; //because we want to play infinite times.
            musicPlayer.play();
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
    @IBAction func musicButtonDown(sender: UIButton) {
        if (musicPlayer.playing == true){
            musicPlayer.stop();
            sender.alpha = 0.3;
        } else{
            musicPlayer.play();
            sender.alpha = 1;
        }
    }
}

