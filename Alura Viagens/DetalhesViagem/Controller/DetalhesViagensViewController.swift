//
//  DetalhesViagensViewController.swift
//  Alura Viagens
//
//  Created by Mauro Augusto Diniz on 05/03/19.
//  Copyright © 2019 Mauro Augusto Diniz. All rights reserved.
//

import UIKit

class DetalhesViagensViewController: UIViewController {

    @IBOutlet weak var imagemPacoteViagem: UIImageView!
    @IBOutlet weak var labelTituloPacoteViagem: UILabel!
    @IBOutlet weak var labelDescricaoPacoteViagem: UILabel!
    @IBOutlet weak var labelDataViagem: UILabel!
    @IBOutlet weak var labelPrecoPacoteViagem: UILabel!
    @IBOutlet weak var imagemPassagemAerea: UIImageView!
    @IBOutlet weak var imagemHotel: UIImageView!
    @IBOutlet weak var imagemCafeDaManha: UIImageView!
    
    var pacoteSelecionado: PacoteViagem? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let pacote = pacoteSelecionado{
            self.imagemPacoteViagem.image = UIImage(named: pacote.viagem.caminhoDaImagem)
            self.labelTituloPacoteViagem.text = pacote.viagem.titulo
            self.labelDescricaoPacoteViagem.text = pacote.descricao
            self.labelDataViagem.text = pacote.dataViagem
            self.labelPrecoPacoteViagem.text = pacote.viagem.preco
            
           /* self.imagemPassagemAerea.image = UIImage(named: "icon_airplane.png")
            self.imagemHotel.image = UIImage(named: "icon_hotel.png")
            self.imagemCafeDaManha.image = UIImage(named: "icon_breakfast.png") */
        }
        
    }
    
    @IBAction func botaoVoltar(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
