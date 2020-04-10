//
//  CoreDataPokemon.swift
//  PokemonGO
//
//  Created by Savio Martins Valentim on 07/04/20.
//  Copyright © 2020 Savio Martins Valentim. All rights reserved.
//

import UIKit
import CoreData

class CoreDataPokemon {
    
    //Recuperar Context
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext
        
        return context!
    }
    
    
    //Adicionar todos os pokemons
    func adicionarTodos(){
        self.criaPokemon(nome: "Mew", nomeImagem: "mew", capturado: false)
        self.criaPokemon(nome: "Meowth", nomeImagem: "meowth", capturado: false)
        self.criaPokemon(nome: "Pikachu", nomeImagem: "pikachu-2", capturado: false)
        self.criaPokemon(nome: "Squirtle", nomeImagem: "squirtle", capturado: false)
        self.criaPokemon(nome: "Charmander", nomeImagem: "charmander", capturado: false)
        self.criaPokemon(nome: "Caterpie", nomeImagem: "caterpie", capturado: false)
        self.criaPokemon(nome: "Bullbasaur", nomeImagem: "bullbasaur", capturado: false)
        self.criaPokemon(nome: "Bellsprout", nomeImagem: "bellsprout", capturado: false)
        self.criaPokemon(nome: "Psyduck", nomeImagem: "psyduck", capturado: false)
        self.criaPokemon(nome: "Rattata", nomeImagem: "snorlax", capturado: false)
        self.criaPokemon(nome: "Zubat", nomeImagem: "zubat", capturado: false)
        
        let context = self.getContext()
        
        do{
            try context.save()
        } catch {
            
        }
    }
    
    //criar pokemons
    func criaPokemon(nome: String, nomeImagem: String, capturado: Bool) {
        let context = self.getContext()
        let pokemon = Pokemon(context: context)
        pokemon.nome = nome
        pokemon.nomeImagem = nomeImagem
        pokemon.capturado = capturado
    }
    
    func recuperarTodosPokemons() -> [Pokemon]{
       
        let context = self.getContext()
        
        do {
            let pokemons = try context.fetch( Pokemon.fetchRequest() ) as! [Pokemon]
            
            if pokemons.count == 0 {
                self.adicionarTodos()
                return self.recuperarTodosPokemons()
            }
            
            return pokemons
        } catch {}
        
        return []
    }
    
    func recuperarPokemonsCapturados(capturado: Bool) -> [Pokemon] {
        let context = self.getContext()
        
        let requisicao = Pokemon.fetchRequest() as NSFetchRequest<Pokemon>
        requisicao.predicate = NSPredicate(format: "capturado = %@", NSNumber(booleanLiteral: capturado))
        
        do{
            let pokemons = try context.fetch( requisicao ) as [Pokemon]
            return pokemons
        }catch{}
        
        return []
    }
    
    func salvarPokemon(pokemon: Pokemon){
        let context = self.getContext()
        pokemon.capturado = true
        
        do{
            try context.save()
        } catch{}
    }
    
}
