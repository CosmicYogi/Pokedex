//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by mitesh soni on 05/07/16.
//  Copyright © 2016 Mitesh Soni. All rights reserved.
//

import UIKit
class PokemonDetailVC: UIViewController {

    
    @IBOutlet var mainPokemonImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var defenseLabel: UILabel!
    @IBOutlet var heightLabel: UILabel!
    @IBOutlet var pokedexIdLabel: UILabel!
    @IBOutlet var weightLabel: UILabel!
    @IBOutlet var baseAttackLabel: UILabel!
    
    @IBOutlet var evolveLabel: UILabel!
    @IBOutlet var currentEvolvingImage: UIImageView!
    @IBOutlet var nextEvolvingImage: UIImageView!
    
    
    var pokemon : Pokemon!
    override func viewDidLoad() {
        nameLabel.text = pokemon.name;
    }
    
    
    @IBAction func onBackDown(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil);
    }
    
}
