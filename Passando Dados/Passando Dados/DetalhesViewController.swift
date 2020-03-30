//
//  DetalhesViewController.swift
//  Passando Dados
//
//  Created by Savio Martins on 04/02/20.
//  Copyright © 2020 SVM Dev. All rights reserved.
//

import UIKit

class DetalhesViewController: UIViewController {

    
    @IBOutlet weak var resultadoLegenda: UILabel!
    var textoRecebido: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultadoLegenda.text = textoRecebido

        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
