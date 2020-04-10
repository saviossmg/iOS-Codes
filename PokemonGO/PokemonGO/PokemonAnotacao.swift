//
//  PokemonAnotacao.swift
//  PokemonGO
//
//  Created by Savio Martins Valentim on 08/04/20.
//  Copyright © 2020 Savio Martins Valentim. All rights reserved.
//

import UIKit
import MapKit

class PokemonAnotacao: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var pokemon: Pokemon
    
    init(coordenadas: CLLocationCoordinate2D, pokemon: Pokemon) {
        self.coordinate = coordenadas
        self.pokemon = pokemon
    }
    
}
