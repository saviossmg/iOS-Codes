//
//  ViewController.swift
//  Son dos Bichos
//
//  Created by Savio Martins Valentim on 09/04/20.
//  Copyright © 2020 Savio Martins Valentim. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer!

    @IBAction func cao(_ sender: Any) {
        self.execSom(nome: "cao.mp3")
    }
    
    @IBAction func gato(_ sender: Any) {
        self.execSom(nome: "gato.mp3")
    }
    
    @IBAction func leao(_ sender: Any) {
        self.execSom(nome: "leao.mp3")
    }
    
    @IBAction func caco(_ sender: Any) {
        self.execSom(nome: "macaco.mp3")
    }
    
    @IBAction func ovelha(_ sender: Any) {
        self.execSom(nome: "ovelha.mp3")
    }
    
    @IBAction func vaca(_ sender: Any) {
        self.execSom(nome: "vaca.mp3")
    }
    
    func execSom(nome: String){
        if let path = Bundle.main.path(forResource: nome, ofType: nil) {
            let url = URL(fileURLWithPath: path)
            do {
                player = try AVAudioPlayer(contentsOf: url)
                player.prepareToPlay()
                player.play()
            } catch {}
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

