//
//  ViewController.swift
//  Onde Estou
//
//  Created by Savio Martins Valentim on 26/03/20.
//  Copyright © 2020 Savio Martins Valentim. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapa: MKMapView!
    
    @IBOutlet weak var velocidade: UILabel!
    @IBOutlet weak var lat: UILabel!
    @IBOutlet weak var lon: UILabel!
    @IBOutlet weak var end: UILabel!
    
    var gerenciadorLocalizacao = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gerenciadorLocalizacao.delegate = self
        gerenciadorLocalizacao.desiredAccuracy = kCLLocationAccuracyBest
        gerenciadorLocalizacao.requestWhenInUseAuthorization()
        gerenciadorLocalizacao.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let localizacaoUsuario = locations.last!
        
        let long = localizacaoUsuario.coordinate.longitude
        let lati = localizacaoUsuario.coordinate.latitude
        
        lon.text = String(format: "%f", long)
        lat.text = String(format: "%f", lati)
        
        velocidade.text = String(format: "%.2f", localizacaoUsuario.speed)
        
        
        var dLat: CLLocationDegrees = 0.01
        var dLon: CLLocationDegrees = 0.01
        
        let localizacao: CLLocationCoordinate2D = CLLocationCoordinate2D.init(latitude: lati, longitude: long)
        let areaExibicao: MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: dLat, longitudeDelta: dLon)
        let regiao: MKCoordinateRegion = MKCoordinateRegion.init(center: localizacao, span: areaExibicao)
        
        mapa.setRegion(regiao, animated: true)
        
        //recupera endereço
        CLGeocoder().reverseGeocodeLocation(localizacaoUsuario) { (detalhesLocal, erro) in
            if erro == nil {
                
                if let dadosLocal = detalhesLocal?.first {
                    var thoroughFare = ""
                    if dadosLocal.thoroughfare != nil {
                        thoroughFare = dadosLocal.thoroughfare!
                    }
                    
                    var subThoroughFare = ""
                    if dadosLocal.subThoroughfare != nil {
                        subThoroughFare = dadosLocal.subThoroughfare!
                    }
                    
                    var locality = ""
                    if dadosLocal.locality != nil {
                        locality = dadosLocal.locality!
                    }
                    
                    var subLocality = ""
                    if dadosLocal.subThoroughfare != nil {
                        subLocality = dadosLocal.subLocality!
                    }
                    
                    var postalCode = ""
                    if dadosLocal.subThoroughfare != nil {
                        postalCode = dadosLocal.postalCode!
                    }
                    
                    var country = ""
                    if dadosLocal.country != nil {
                        country = dadosLocal.country!
                    }
                    
                    var administrativeArea = ""
                    if dadosLocal.administrativeArea != nil {
                        administrativeArea = dadosLocal.administrativeArea!
                    }
                    
                    var subAdministrativeArea = ""
                    if dadosLocal.subAdministrativeArea != nil {
                        subAdministrativeArea = dadosLocal.subAdministrativeArea!
                    }
                    
                    self.end.text = thoroughFare + " - "
                                    + subThoroughFare + " / "
                                    + locality + " / "
                                    + country
                }
                
            } else {
                print(erro)
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status != .authorizedWhenInUse{
            let alertaController = UIAlertController(
                title: "Permissão de localização",
                message: "Necessário permissão para acesso à sua localização: por favor habilite.",
                preferredStyle: .alert
            )
            let acaoConfig = UIAlertAction(title: "Abir configurações", style: .default) { (alertaConfiguracoes) in
                if let configuracoes = NSURL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(configuracoes as URL)
                }
            }
            
            let acaoCancel = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
            
            alertaController.addAction(acaoConfig)
            alertaController.addAction(acaoCancel)
            
            present(alertaController, animated: true, completion: nil)
            
        }
    }


}
