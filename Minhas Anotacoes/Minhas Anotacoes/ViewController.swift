//
//  ViewController.swift
//  Minhas Anotacoes
//
//  Created by Savio Martins Valentim on 11/03/20.
//  Copyright © 2020 Savio Martins Valentim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let chave = "minhaAnotacao"
    
    @IBOutlet weak var textoCampo: UITextView!
    
    @IBAction func salvarAnotacao(_ sender: Any) {
        
        if let texto = textoCampo.text {
            UserDefaults.standard.set(texto, forKey: chave)
        }
        
    }
    
    func recuperarAnotacao() -> String {
        
        if let textoRecuperado = UserDefaults.standard.object(forKey: chave){
            return textoRecuperado as! String
        }
        
        return ""
    }
    
    //esconder barra de status
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //esconder teclado
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textoCampo.text = recuperarAnotacao()
    }

}
