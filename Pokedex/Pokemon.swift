//
//  Pokemon.swift
//  Pokedex
//
//  Created by mitesh soni on 01/07/16.
//  Copyright © 2016 Mitesh Soni. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon{
    
    private var _name : String!
    private var _pokedexId : Int!
    private var _bio : String!
    private var _type : String!
    private var _defense : String!
    private var _height : String!
    private var _weight : String!
    private var _baseAttack : String!
    private var _pokemonUrl: String!
    
    init(name : String, pokedexId: Int){
        _name = name;
        _pokedexId = pokedexId
        
        _pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self._pokedexId)/"
    }
    
    var name : String{
        return _name;
    }
    var pokedexId: Int{
        return _pokedexId
    }
    
    func downloadPokemonDetails(completed: DownloadComplete){
        let url = NSURL(string: _pokemonUrl)!
        
        Alamofire.request(.GET, url).responseJSON { (response) in
            //print(response.debugDescription)
            //print(response.result.value)
            if let dict = response.result.value as? Dictionary<String,AnyObject>{
                
                if let weight = dict["weight"] as? String{
                    self._weight = weight;
                }
                if let height = dict["height"] as? String{
                    self._height = height;
                }
                if let attack = dict["attack"] as? Int{
                    self._baseAttack = "\(attack)";
                }
                if let defense = dict["defense"] as? Int{
                    self._defense = "\(defense)";
                }
                
                print(self._weight);
                print(self._height);
                print(self._defense);
                print(self._baseAttack);
                
                if let types = dict["types"] as? [Dictionary<String,String>] where types.count > 0{
                    
                    if let name = types[0]["name"] {
                        self._type = name;
                    }
                    if types.count > 1{
                        
                        for var x = 1 ; x < types.count ; x += 1{
                            if let name = types[x]["name"]{
                                self._type! += "/\(name)";
                            }
                        }
                    }
                    
                }
                else{
                    self._type = "";
                }
                print(self._type);
            }
        }
        
        
    }
}