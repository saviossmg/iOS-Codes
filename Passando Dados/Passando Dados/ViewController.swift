//
//  ViewController.swift
//  Passando Dados
//
//  Created by Savio Martins on 04/02/20.
//  Copyright © 2020 SVM Dev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var nomeCampo: UITextField!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "enviarDados" {
            
            let vcDestino = segue.destination as!
            DetalhesViewController
            
            vcDestino.textoRecebido = nomeCampo.text!
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

