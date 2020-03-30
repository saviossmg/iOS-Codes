//
//  DetalheFilmeViewController.swift
//  Meus Filmes
//
//  Created by Savio Martins Valentim on 10/03/20.
//  Copyright © 2020 Savio Martins Valentim. All rights reserved.
//

import UIKit

class DetalheFilmeController: UIViewController {
    
    @IBOutlet weak var filmeImage: UIImageView!
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var descricao: UILabel!
    
    
    var filme: Filme!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filmeImage.image = filme.imagem
        titulo.text = filme.titulo
        descricao.text = filme.descricao
        
        
    }
    
}
