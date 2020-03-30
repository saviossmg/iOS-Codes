//
//  AmazenamentoDados.swift
//  Minhas Viagens
//
//  Created by Savio Martins Valentim on 30/03/20.
//  Copyright © 2020 Savio Martins Valentim. All rights reserved.
//

import UIKit

class ArmazenamentoDados {
    
    let chaveArmazenamento = "locaisViagem"
    var viagens: [Dictionary<String, String>] = []
    
    func getDefaults() -> UserDefaults {
        return UserDefaults.standard
    }
    
    func salvarViagem(  viagem: Dictionary<String, String> ){
        
        viagens = listarViagens()
        
        viagens.append( viagem )
        
        getDefaults().set(viagens, forKey: chaveArmazenamento)
        getDefaults().synchronize()
        
    }
    
    func listarViagens() -> [Dictionary<String, String>]{
        let dados = getDefaults().object(forKey: "locaisViagem")
        if dados != nil {
            return dados as! Array
        } else {
            return []
        }
    }
    
    func removerViagem(indice: Int){
        
        viagens = listarViagens()
        viagens.remove(at: indice)
        
        getDefaults().set(viagens, forKey: chaveArmazenamento)
        getDefaults().synchronize()
        
    }
    
}
