//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by mitesh soni on 05/07/16.
//  Copyright © 2016 Mitesh Soni. All rights reserved.
//

import UIKit
class PokemonDetailVC: UIViewController {

    var pokemon : Pokemon!
    
    @IBOutlet var nameLabel: UILabel!
    
    override func viewDidLoad() {
        nameLabel.text = pokemon.name;
    }
    
}
