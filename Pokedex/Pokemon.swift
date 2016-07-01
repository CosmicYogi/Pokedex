//
//  Pokemon.swift
//  Pokedex
//
//  Created by mitesh soni on 01/07/16.
//  Copyright © 2016 Mitesh Soni. All rights reserved.
//

import Foundation
class Pokemon{
    
    private var _name : String
    private var _pokedexId : Int
    
    init(name : String, pokedexId: Int){
        _name = name;
        _pokedexId = pokedexId
    }
    
    var name : String{
        return _name;
    }
    var pokedexId: Int{
        return _pokedexId
    }
}