//
//  ViewController.swift
//  Alerta
//
//  Created by Savio Martins on 26/02/20.
//  Copyright © 2020 SVM Dev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func abrirAlerta(_ sender: UIButton) {
        
        let alerta = UIAlertController(
            title: "Adicionar Contato", message: "Deseja adicionar um contato?", preferredStyle: .alert)
        
        let confirmar = UIAlertAction(title: "Confirmar", style: .default, handler: nil)
        let cancelar = UIAlertAction(title: "Cancelar", style: .destructive , handler: nil)
        
        alerta.addAction(confirmar)
        alerta.addAction(cancelar)
        
        present(alerta,animated: true)
        
        
    }
    
}

