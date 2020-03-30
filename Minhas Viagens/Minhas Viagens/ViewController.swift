//
//  ViewController.swift
//  Minhas Viagens
//
//  Created by Savio Martins Valentim on 27/03/20.
//  Copyright © 2020 Savio Martins Valentim. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapa: MKMapView!
    var gerenciadorLocalizacao = CLLocationManager()
    var viagem: Dictionary<String, String> = [:]
    var indiceSelecionado: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let indice = indiceSelecionado {
            if indice == -1 {
                // adicionar
                configGerenciadorLocalizacao()
            } else {
                // listar
                exibirAnotacao(viagem: viagem)
                
            }
        }
        
        let reconhedorGesto = UILongPressGestureRecognizer(target: self, action: #selector( ViewController.marcar(gesture:) ))
        reconhedorGesto.minimumPressDuration = 2
        
        mapa.addGestureRecognizer(reconhedorGesto)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let local = locations.last!
        
        //exibir local
        let localizacao = CLLocationCoordinate2D.init(latitude: local.coordinate.latitude, longitude: local.coordinate.longitude)
        let span = MKCoordinateSpan.init(latitudeDelta: 0.01, longitudeDelta: 0.01)
        
        let regiao: MKCoordinateRegion = MKCoordinateRegion.init(center: localizacao, span: span)
        self.mapa.setRegion(regiao, animated: true)
        
    }
    
    func exibirLocal(latitude: Double, longitude: Double){
        //exibir local
        let localizacao = CLLocationCoordinate2D.init(latitude: latitude, longitude: longitude)
        let span = MKCoordinateSpan.init(latitudeDelta: 0.01, longitudeDelta: 0.01)
        
        let regiao: MKCoordinateRegion = MKCoordinateRegion.init(center: localizacao, span: span)
        self.mapa.setRegion(regiao, animated: true)
        
    }
    
    func exibirAnotacao(viagem: Dictionary<String,String>){
        //Exibe anotacao com os dados
        if let localViagem = viagem["local"] {
    
            if let latitudeS = viagem["latitude"] {
                if let longitudeS = viagem["longitude"]{
                    
                    if let latitude = Double(latitudeS){
                        if let longitude = Double(longitudeS){

                            //Exibir anotação
                            let anotacao = MKPointAnnotation()
                            
                            anotacao.coordinate.latitude = latitude
                            anotacao.coordinate.longitude = longitude
                            anotacao.title = localViagem
                            
                            self.mapa.addAnnotation(anotacao)
                            
                            //exibir local
                            exibirLocal(latitude: latitude, longitude: longitude)
                            
                        }
                    }
                    
                }
            }
            
        }
    }
    
    @objc func marcar(gesture: UIGestureRecognizer){
        if gesture.state == UIGestureRecognizer.State.began {
            //Recupera as coordenadas
            let pontoSelecionado = gesture.location(in: self.mapa)
            let coordenadas = mapa.convert(pontoSelecionado, toCoordinateFrom: self.mapa)
            let localizacao = CLLocation(latitude: coordenadas.latitude, longitude: coordenadas.longitude)
            
            //Recupera o endereço
            var localCompleto = "Endereço não encontrado."
            
            CLGeocoder().reverseGeocodeLocation( localizacao ) { (local, erro) in
                if erro == nil {
                    
                    if let dadosLocal = local?.first {
                        
                        if let nome = dadosLocal.name {
                            localCompleto = nome
                        } else {
                            
                            if let endereco = dadosLocal.thoroughfare {
                                localCompleto = endereco
                            }
                            
                        }
                        
                    }
                    
                    //Salvar dados no dispostivo
                    self.viagem = ["local":localCompleto, "latitude": String(coordenadas.latitude), "longitude": String(coordenadas.longitude)]
                    ArmazenamentoDados().salvarViagem(viagem: self.viagem)
                    
                    self.exibirAnotacao(viagem: self.viagem)
                    
                } else {
                    
                    print(erro)
                    
                }
            }
            
        }
        
    }
    
    func configGerenciadorLocalizacao() {
        //config do gerenciador de localizaco
        gerenciadorLocalizacao.delegate = self
        gerenciadorLocalizacao.desiredAccuracy = kCLLocationAccuracyBest
        gerenciadorLocalizacao.requestWhenInUseAuthorization()
        gerenciadorLocalizacao.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        //alerta para caso a autorização não tenha sido dada.
        if status != .authorizedWhenInUse {
            
            let alertaController = UIAlertController(title: "Permissão de Localização",
                                                     message: "Necessário permissão para acesso à sia localização. Por favor habilite.",
                                                     preferredStyle: .alert)
            
            let acaoConfiguracoes = UIAlertAction(title: "Abrir Configuracoes", style: .default, handler: { (alertaConfiguracoes) in
                
                if let configuracoes = NSURL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open( configuracoes as URL)
                }
                
            })
            
            let acaoCancelar = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
            
            alertaController.addAction(acaoConfiguracoes)
            alertaController.addAction(acaoCancelar)
            
            present(alertaController, animated: true, completion: nil)
        
        }
    }
    


}
