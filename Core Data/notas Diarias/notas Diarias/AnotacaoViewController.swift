//
//  AnotacaoViewController.swift
//  notas Diarias
//
//  Created by Savio Martins Valentim on 31/03/20.
//  Copyright © 2020 Savio Martins Valentim. All rights reserved.
//

import UIKit
import CoreData

class AnotacaoViewController: UIViewController {

    @IBOutlet weak var texto: UITextView!
    var context: NSManagedObjectContext!
    var anotacao: NSManagedObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //configuracoes iniciais
        self.texto.text = ""
        if anotacao != nil {
            if let textoRecuperado = anotacao.value(forKey: "texto") {
                self.texto.text = String(describing: textoRecuperado)
            }
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext

    }
    
    @IBAction func salvar(_ sender: Any) {
        
        if anotacao != nil {
            self.atualizarAnotacao()
        } else {
            self.salvarAnotacao()
        }
        
        
        //retorna para a tela inicial
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func atualizarAnotacao(){
        anotacao.setValue(self.texto.text, forKey: "texto")
        anotacao.setValue(Date(), forKey: "data")
        
        do{
            try context.save()
            print("Sucesso ao atualizar anotacao!")
        } catch let erro as Error {
            print("Erro ao salvar a anotacao: \(erro.localizedDescription)")
        }
        
    }
    
    func salvarAnotacao() {
        
        let novaAnotacao = NSEntityDescription.insertNewObject(forEntityName: "Anotacao", into: context)
        
        //configura anotacao
        novaAnotacao.setValue(self.texto.text, forKey: "texto")
        novaAnotacao.setValue(Date(), forKey: "data")
        
        do{
            try context.save()
            print("Sucesso ao salvar anotacao!")
        } catch let erro as Error {
            print("Erro ao salvar a anotacao: \(erro.localizedDescription)")
        }
        
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
