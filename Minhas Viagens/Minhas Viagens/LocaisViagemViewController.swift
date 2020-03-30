//
//  LocaisViagemViewController.swift
//  Minhas Viagens
//
//  Created by Savio Martins Valentim on 30/03/20.
//  Copyright © 2020 Savio Martins Valentim. All rights reserved.
//

import UIKit

class LocaisViagemViewController: UITableViewController {

    var locaisViagens: [Dictionary<String, String>] = []
    var controleNavegacao = "adicionar"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        atualizarViagens()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locaisViagens.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viagem = locaisViagens[indexPath.row]["local"]
        let cell = tableView.dequeueReusableCell(withIdentifier: "celulaReuso", for: indexPath)
        cell.textLabel?.text = viagem
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.controleNavegacao = "listar"
        performSegue(withIdentifier: "verLocal", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "verLocal" {
            
            let viewControllerDestino = segue.destination as! ViewController
            
            if let indiceRecuperado = sender {
                
                if self.controleNavegacao == "listar" {
                    let indice = indiceRecuperado as! Int
                    viewControllerDestino.viagem = locaisViagens[ indice ]
                    viewControllerDestino.indiceSelecionado = indice
                } else {
                    viewControllerDestino.viagem = [:]
                    viewControllerDestino.indiceSelecionado = -1
                }
            }
            
        }
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            ArmazenamentoDados().removerViagem(indice: indexPath.row)
            atualizarViagens()
        }
    }
    
    func atualizarViagens() {
        locaisViagens = ArmazenamentoDados().listarViagens()
        tableView.reloadData()
    }

}
