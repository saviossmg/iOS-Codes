//
//  PokeAgendaViewController.swift
//  PokemonGO
//
//  Created by Savio Martins Valentim on 08/04/20.
//  Copyright © 2020 Savio Martins Valentim. All rights reserved.
//

import UIKit

class PokeAgendaViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
 
    var pokemonsCapturados: [Pokemon] = []
    var pokemonsNaoCaptura: [Pokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let coreDataPokemon = CoreDataPokemon()
        
        self.pokemonsCapturados = coreDataPokemon.recuperarPokemonsCapturados(capturado: true)
        self.pokemonsNaoCaptura = coreDataPokemon.recuperarPokemonsCapturados(capturado: false)
    }
    
    @IBAction func voltarMapa(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.pokemonsCapturados.count
        } else {
            return self.pokemonsNaoCaptura.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pokemon: Pokemon
        
        if indexPath.section == 0 {
            pokemon = self.pokemonsCapturados[ indexPath.row ]
        } else {
            pokemon = self.pokemonsNaoCaptura[ indexPath.row ]
        }
        
        let celula = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "celula")
        celula.textLabel?.text = pokemon.nome
        celula.imageView?.image = UIImage(named: pokemon.nomeImagem!)
        
        return celula
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Capturados"
        } else {
            return "Não Capturados"
        }
    }
    
}
