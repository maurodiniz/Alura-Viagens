//
//  ConfirmacaoPagamentoViewController.swift
//  Alura Viagens
//
//  Created by Mauro Augusto Diniz on 07/03/19.
//  Copyright © 2019 Mauro Augusto Diniz. All rights reserved.
//

import UIKit

class ConfirmacaoPagamentoViewController: UIViewController {

    @IBOutlet weak var imagemPacoteViagem: UIImageView!
    @IBOutlet weak var labelTituloPacoteViagem: UILabel!
    @IBOutlet weak var labelHotelPacoteViagem: UILabel!
    @IBOutlet weak var labelDataPacoteViagem: UILabel!
    @IBOutlet weak var labelQuantidadePessoas: UILabel!
    @IBOutlet weak var labeldescricaoPacoteViagem: UILabel!
    @IBOutlet weak var botaoVoltarHome: UIButton!
    
    var pacoteComprado: PacoteViagem? = nil
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let pacote = pacoteComprado{
            self.imagemPacoteViagem.image = UIImage(named: pacote.viagem.caminhoDaImagem)
            self.labelTituloPacoteViagem.text = pacote.viagem.titulo.uppercased()
            self.labelHotelPacoteViagem.text = pacote.nomeDoHotel
            self.labelDataPacoteViagem.text = pacote.dataViagem
            self.labeldescricaoPacoteViagem.text = pacote.descricao
            
            // Setando o tamanho do arredondamento que a imagem deverá ter e em seguida ativo a propriedade .maskstoBounds para que ele mostre o arrredondamento na tela 
            self.imagemPacoteViagem.layer.cornerRadius = 10
            self.imagemPacoteViagem.layer.masksToBounds = true
            
            self.botaoVoltarHome.layer.cornerRadius = 8
        }
        
    }
    @IBAction func botaoVoltarHome(_ sender: UIButton) {
        if let navigation = self.navigationController{
            navigation.popToRootViewController(animated: true)
        }
    }
    
}
