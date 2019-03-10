//
//  PacoteViagemCollectionViewCell.swift
//  Alura Viagens
//
//  Created by Mauro Augusto Diniz on 03/03/19.
//  Copyright © 2019 Mauro Augusto Diniz. All rights reserved.
//

import UIKit

class PacoteViagemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imagemViagem: UIImageView!
    
    @IBOutlet weak var labelTitulo: UILabel!
    
    @IBOutlet weak var labelQuantidadeDias: UILabel!
    
    @IBOutlet weak var labelPreco: UILabel!
    
    func configuraCelula(_ pacoteViagem: PacoteViagem) {
        self.labelTitulo.text = pacoteViagem.viagem.titulo
        self.labelQuantidadeDias.text = "\(pacoteViagem.viagem.quantidadeDeDias) dias"
        self.labelPreco.text = "R$\(pacoteViagem.viagem.preco)"
        self.imagemViagem.image = UIImage(named: pacoteViagem.viagem.caminhoDaImagem)
        
        // setando a borda e o arredondamento da célula, pois por padrão estava transparente e sem arredondamento
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor(red: 85.0/255.0, green: 85.0/255.0, blue: 85.0/255.0, alpha: 1).cgColor
        self.layer.cornerRadius = 8
    }
    
}
