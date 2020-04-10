//
//  ViewController.swift
//  Player Som
//
//  Created by Savio Martins Valentim on 09/04/20.
//  Copyright © 2020 Savio Martins Valentim. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var player: AVAudioPlayer!
    @IBOutlet weak var sliderVolume: UISlider!
    
    @IBAction func play(_ sender: Any) {
        player.play()
    }
    
    @IBAction func pause(_ sender: Any) {
        player.pause()
    }
    
    @IBAction func stop(_ sender: Any) {
        player.stop()
        player.currentTime = 0
    }
    
    @IBAction func volume(_ sender: Any) {
        player.volume = sliderVolume.value
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let path = Bundle.main.path(forResource: "bach.mp3", ofType: nil) {
            let url = URL(fileURLWithPath: path)
            do {
                try player = AVAudioPlayer(contentsOf: url)
                player.prepareToPlay()
            } catch {}
            
        }
        
    }

}
