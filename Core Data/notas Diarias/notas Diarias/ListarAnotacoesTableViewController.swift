//
//  ListarAnotacoesTableViewController.swift
//  notas Diarias
//
//  Created by Savio Martins Valentim on 31/03/20.
//  Copyright © 2020 Savio Martins Valentim. All rights reserved.
//

import UIKit
import CoreData

class ListarAnotacoesTableViewController: UITableViewController {

    var context: NSManagedObjectContext!
    var anotacoes: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.context = appDelegate.persistentContainer.viewContext
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.recuperarAnotacoes()
    }
    
    func recuperarAnotacoes() {
        
        let requisicao = NSFetchRequest<NSFetchRequestResult>(entityName: "Anotacao")
        let ordenacao = NSSortDescriptor(key: "data", ascending: false)
        requisicao.sortDescriptors = [ordenacao]
        
        do {
            let anotacoesRecuperadas = try context.fetch(requisicao)
            self.anotacoes = anotacoesRecuperadas as! [NSManagedObject]
            tableView.reloadData()
        } catch let erro {
            print("Erro ao salvar a anotacao: \(erro.localizedDescription)")
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.anotacoes.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        let indice = indexPath.row
        let anotacao = self.anotacoes[indice]
        
        self.performSegue(withIdentifier: "verAnotacao", sender: anotacao)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "verAnotacao" {
            let viewDestino = segue.destination as! AnotacaoViewController
            viewDestino.anotacao = sender as? NSManagedObject
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celula", for: indexPath)
        let anotacao = self.anotacoes[ indexPath.row ]
        
        let texto = anotacao.value(forKey: "texto")
        let data = anotacao.value(forKey: "data")
        
        //formatar data
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm"
        
        let dataFormatada = dateFormatter.string(from: data as! Date)
        print(dataFormatada)
        
        cell.textLabel?.text = texto as? String
        cell.detailTextLabel?.text = dataFormatada
        
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let indice = indexPath.row
            let anotacao = self.anotacoes[indice]
            self.context.delete(anotacao)
            self.anotacoes.remove(at: indice)
            
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
            do{
                try self.context.save()
            } catch let erro {
                print("Erro ao remover item \(erro)")
            }
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
