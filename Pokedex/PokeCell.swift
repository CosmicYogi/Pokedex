//
//  PokeCell.swift
//  Pokedex
//
//  Created by mitesh soni on 01/07/16.
//  Copyright © 2016 Mitesh Soni. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var thumbnailImage : UIImageView!
    
    var pokemon : Pokemon!
    
    func configureCell(pokemon : Pokemon){
        self.pokemon = pokemon;
        nameLabel.text = self.pokemon.name;
        thumbnailImage.image = UIImage(named: "\(self.pokemon.pokedexId)");
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 5;
    }
    
}
