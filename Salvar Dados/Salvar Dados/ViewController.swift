//
//  ViewController.swift
//  Salvar Dados
//
//  Created by Savio Martins Valentim on 11/03/20.
//  Copyright © 2020 Savio Martins Valentim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //pequenas inforçãoes
        //UserDefaults.standard.set("azul", forKey: "corFundo")
        //let texto = UserDefaults.standard.object(forKey: "corFundo")
        //print(texto)
        
        //var comidas: [String] = ["Lasangha","Pizza", "Torta"]
        //UserDefaults.standard.set(comidas, forKey: "comidas")
        
        UserDefaults.standard.removeObject(forKey: "comidas")
        
        let retorno = UserDefaults.standard.object(forKey: "corFundo")
        print(retorno)
        
    }


}

