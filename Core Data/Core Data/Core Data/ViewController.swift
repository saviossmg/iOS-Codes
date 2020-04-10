//
//  ViewController.swift
//  Core Data
//
//  Created by Savio Martins Valentim on 31/03/20.
//  Copyright © 2020 Savio Martins Valentim. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //objeto appDelegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        /*
        //Criar entidade
        let usuario = NSEntityDescription.insertNewObject(forEntityName: "Usuario", into: context)
        
        //Configura objeto
        usuario.setValue("Roberta Campos", forKey: "nome")
        usuario.setValue(24, forKey: "idade")
        usuario.setValue("roberta.cm", forKey: "login")
        usuario.setValue("1234", forKey: "senha")
        
        //Salvar (persistir) os dados
        //precisa de try catch
        do {
            try context.save()
            print("Dados salvos com sucesso")
        } catch {
            print("Erro ao salvar os dados")
        }
        */
        
        //Cria uma requisicao
        let requisicao = NSFetchRequest<NSFetchRequestResult>(entityName: "Usuario")
        
        //Ordenar de A-Z ou Z-A
        let ordenacaoAZ = NSSortDescriptor(key: "nome", ascending: true)
        //let ordenacaoZA = NSSortDescriptor(key: "idade", ascending: false)
        
        //Aplicar filtros
        //let predicate = NSPredicate(format: "nome == %@","Roberta")
        let predicate = NSPredicate(format: "nome contains [c] %@","Roberta")
        
        let filtroNome = NSPredicate(format: "nome contains [c] %@ ","os")
        let filtroIdade = NSPredicate(format: "idade >= %@ ","20")
        let combinacaoFitro = NSCompoundPredicate(orPredicateWithSubpredicates: [filtroNome,filtroIdade] )
        
        //aplicar filtros criados à requisição
        requisicao.sortDescriptors = [ordenacaoAZ]
        requisicao.predicate = predicate
        
        do{
            let usuarios = try context.fetch(requisicao)
            
            if usuarios.count > 0 {
                
                for usuario in usuarios as! [NSManagedObject]{
                    
                    if let nomeUsuario = usuario.value(forKey: "nome") {
                        if let loginUsuario = usuario.value(forKey: "login") {
                            if let idadeUsuario = usuario.value(forKey: "idade") {
                                print(String(describing: nomeUsuario) + " | " + String(describing: loginUsuario) + " | " + String(describing: idadeUsuario))
                                
                                //remover
                                /*
                                context.delete(usuario)
                                do {
                                    //aleracao pode ser feita apenas no final
                                    try context.save()
                                    print("Sucesso ao remover o usuario.")
                                } catch {
                                    print("Erro ao remover o usuario.")
                                }
                                */
                                
                                //atualizar
                                /*
                                usuario.setValue(50, forKey: "idade")
                                do {
                                   try context.save()
                                   print("Dados atualizados com sucesso")
                               } catch {
                                   print("Erro ao salvar os dados")
                               }
                                */
                            }
                        }
                    }
                    
                }
                
            } else {
                print("Nenhum usuario encontrado!")
            }
            
        } catch {
            print("Erro ao recuperar os usuarios!")
        }
        
        
    }


}

