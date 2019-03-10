//
//  TableViewCell.swift
//  Alura Viagens
//
//  Created by Mauro Augusto Diniz on 25/02/19.
//  Copyright © 2019 Mauro Augusto Diniz. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var labelTitulo: UILabel!
    @IBOutlet weak var labelQuantidadeDeDias: UILabel!
    
    @IBOutlet weak var labelPreco: UILabel!
    @IBOutlet weak var imagemViagem: UIImageView!
    
    func configuraCelula(_ viagem: Viagem) {
        self.labelTitulo.text = viagem.titulo
        self.labelQuantidadeDeDias.text = viagem.quantidadeDeDias == 1 ? "1 dia" : "\(viagem.quantidadeDeDias) dias"
        self.labelPreco.text = "R$\(viagem.preco)"
        self.imagemViagem.image = UIImage(named: viagem.caminhoDaImagem)
        
        // comandos para deixar a imagem de cada célula com os cantos arredondados.
        self.imagemViagem.layer.cornerRadius = 10
        self.imagemViagem.layer.masksToBounds = true
    }
    
}
