//
//  Filme.swift
//  Meus Filmes
//
//  Created by Savio Martins Valentim on 10/03/20.
//  Copyright © 2020 Savio Martins Valentim. All rights reserved.
//

import UIKit

class  Filme {
    
    var titulo: String!
    var descricao: String!
    var imagem: UIImage!
    
    init(titulo: String, descricao: String, imagem: UIImage) {
        self.titulo = titulo
        self.descricao = descricao
        self.imagem = imagem
    }
    
}
