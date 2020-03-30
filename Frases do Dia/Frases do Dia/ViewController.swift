//
//  ViewController.swift
//  Frases do Dia
//
//  Created by Savio Martins on 28/07/19.
//  Copyright © 2019 SVM Dev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var fraseMostrar: UILabel!
    
    @IBAction func novaFrase(_ sender: Any) {
        var frases: [String] = []
        frases.append("Se você traçar metas absurdamente altas e falhar, o fracasso será muito melhor que o sucesso de todos.")
        frases.append("Ter sucesso é falahar repetidamente, mas sem perder o entusiasmo.")
        frases.append("Uma frase qualquer.")
        
        let nAleatorio = arc4random_uniform(3)
        fraseMostrar.text = frases[ Int(nAleatorio) ]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

