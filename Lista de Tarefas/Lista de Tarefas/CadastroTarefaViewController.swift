//
//  ViewController.swift
//  Lista de Tarefas
//
//  Created by Savio Martins Valentim on 19/03/20.
//  Copyright © 2020 Savio Martins Valentim. All rights reserved.
//

import UIKit

class CadastroTarefaViewController: UIViewController {

    @IBOutlet weak var tarefaCampo: UITextField!
    
    @IBAction func adicionarTarefa(_ sender: Any) {
        if let textoDigitado = tarefaCampo.text {
            
            let tarefa = TarefaUserDefaults()
            tarefa.salvar(tarefa: textoDigitado)
            tarefaCampo.text = ""
            
            let dados = tarefa.listar()
            
            print( dados )
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
