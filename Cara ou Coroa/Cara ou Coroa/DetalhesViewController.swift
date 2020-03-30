//
//  DetalhesViewController.swift
//  Cara ou Coroa
//
//  Created by Savio Martins on 10/02/20.
//  Copyright © 2020 SVM Dev. All rights reserved.
//

import UIKit

class DetalhesViewController: UIViewController {

    var numeroRandomico: Int!
    
    @IBOutlet weak var moedaImagem: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("numero eh \(String(describing: numeroRandomico))")

        if numeroRandomico == 0 {
            //cara
            moedaImagem.image = #imageLiteral(resourceName: "moeda_cara")
        } else {
            //coroa
            moedaImagem.image = #imageLiteral(resourceName: "moeda_coroa")
        }
        
    }

}
