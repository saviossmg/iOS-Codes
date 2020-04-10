//
//  ViewController.swift
//  PokemonGO
//
//  Created by Savio Martins Valentim on 06/04/20.
//  Copyright © 2020 Savio Martins Valentim. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapa: MKMapView!
    var gerenciadorLocalizacao = CLLocationManager()
    var contador = 0
    var coreDataPokemon: CoreDataPokemon!
    var pokemons: [Pokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapa.delegate = self
        gerenciadorLocalizacao.delegate = self
        gerenciadorLocalizacao.requestWhenInUseAuthorization()
        gerenciadorLocalizacao.startUpdatingLocation()
        
        //recuperar pokemons
        self.coreDataPokemon = CoreDataPokemon()
        self.pokemons = self.coreDataPokemon.recuperarTodosPokemons()
        
        //Exibir Pokemons
        Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { (timer) in
            
            if let coordenadas = self.gerenciadorLocalizacao.location?.coordinate {
                
                let totalPokemons = UInt32(self.pokemons.count)
                let indicePokemonAleatorio = arc4random_uniform(totalPokemons)
                
                let pokemon = self.pokemons[ Int(indicePokemonAleatorio) ]
                
                let anotacao = PokemonAnotacao(coordenadas: coordenadas, pokemon: pokemon)
                
                let latAleatoria = (Double(arc4random_uniform(500)) - 250) / 10000.0
                let longAleatoria = (Double(arc4random_uniform(500)) - 250) / 10000.0
                
                anotacao.coordinate = coordenadas
                anotacao.coordinate.latitude += latAleatoria
                anotacao.coordinate.longitude += longAleatoria
                
                self.mapa.addAnnotation( anotacao )
            }
            
        }
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let anotacaoView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
                
        if annotation is MKUserLocation {
            anotacaoView.image = #imageLiteral(resourceName: "player")
        } else {
            let pokemon = (annotation as! PokemonAnotacao).pokemon
            anotacaoView.image = UIImage(named: pokemon.nomeImagem! )
        }
        
        var frame = anotacaoView.frame
        frame.size.height = 40
        frame.size.width = 40
        
        return anotacaoView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let anotacao = view.annotation
        let coordenadas = anotacao?.coordinate
        mapView.deselectAnnotation(anotacao, animated: true)
        
        if anotacao is MKUserLocation {
            return
        }
        
        let regiao = MKCoordinateRegion.init( center: coordenadas!, latitudinalMeters: 200, longitudinalMeters: 200)
        mapView.setRegion(regiao, animated: true)
        
        let pokemon = (view.annotation as! PokemonAnotacao).pokemon
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (timer) in
            if let coord = self.gerenciadorLocalizacao.location?.coordinate {
                if self.mapa.visibleMapRect.contains(MKMapPoint(coord)) {
                    self.coreDataPokemon.salvarPokemon(pokemon: pokemon)
                    self.mapa.removeAnnotation(anotacao!)
                    
                    let alertController = UIAlertController(
                        title: "Parabéns!",
                        message: "Você capturou o pokémon: \(pokemon.nome!)",
                        preferredStyle: .alert
                    )
                    let ok = UIAlertAction(title: "ok", style: .default, handler: nil)
                    alertController.addAction(ok)
                    
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    let alertController = UIAlertController(
                        title: "Você não pode capturar",
                        message: "Você precisa se aproximar mais para capturar o \(pokemon.nome!)",
                        preferredStyle: .alert)
                    
                    let ok = UIAlertAction(title: "ok", style: .default, handler: nil)
                    alertController.addAction(ok)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if contador < 3 {
            self.centralizar()
            contador += 1
        } else {
            gerenciadorLocalizacao.stopUpdatingHeading()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status != .authorizedWhenInUse && status != .notDetermined {
            
            //alerta
            let alertController = UIAlertController (
                title: "Permissão de Localização",
                message: "Habilite a localização para caçar Pokemons.",
                preferredStyle: .alert
            )
            
            let acaoConfiguracoes = UIAlertAction(title: "Abrir configurações", style: .default, handler: {
                (alertaConfiguracoes) in
                
                if let configs = NSURL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(configs as URL)
                }
            })
            
            let acaoCancelar = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
            
            alertController.addAction(acaoConfiguracoes)
            alertController.addAction(acaoCancelar)
            
            present(alertController, animated: true, completion: nil)
        }
    }
    
    func centralizar(){
        if let coordenadas = gerenciadorLocalizacao.location?.coordinate {
            let regiao = MKCoordinateRegion.init(center: coordenadas, latitudinalMeters: 200, longitudinalMeters: 200)
            mapa.setRegion(regiao, animated: true)
        }
        
    }
    
    @IBAction func centralizarJogador(_ sender: Any) {
        self.centralizar()
    }
    
    @IBAction func abrirPokedex(_ sender: Any) {
        
    }
    
}
