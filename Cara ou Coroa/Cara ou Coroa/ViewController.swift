//
//  ViewController.swift
//  Cara ou Coroa
//
//  Created by Savio Martins on 10/02/20.
//  Copyright © 2020 SVM Dev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "jogarMoeda" {
            let vcDestino = segue.destination as! DetalhesViewController
            let valor = Int.random(in: 0 ... 1)
            vcDestino.numeroRandomico = valor
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

