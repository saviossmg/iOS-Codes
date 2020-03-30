//
//  ViewController.swift
//  Idade de Cachorro
//
//  Created by Savio Martins on 27/07/19.
//  Copyright © 2019 SVM Dev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var legendaResultado: UILabel!
    
    @IBOutlet weak var campoIdadeCachorro: UITextField!
    
    
    @IBAction func descobrirIdade(_ sender: Any) {
        let idade = Int(campoIdadeCachorro.text!)! * 7
        legendaResultado.text = "A idade do cachorro é: "+String(idade)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


}

