//
//  ViewController.swift
//  Alura Viagens
//
//  Created by Mauro Augusto Diniz on 23/02/19.
//  Copyright © 2019 Mauro Augusto Diniz. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tabelaViagens: UITableView!
    
    @IBOutlet weak var viewHoteis: UIView!
    @IBOutlet weak var viewPacotes: UIView!
    
    let listaViagens: Array<Viagem> = ViagemDAO().retornaTodasAsViagens()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tabelaViagens.dataSource = self
        self.tabelaViagens.delegate = self
        
        self.viewHoteis.layer.cornerRadius = 10
        self.viewPacotes.layer.cornerRadius = 10
    }

    // Método obrigatório onde devemos informar a quantidade de células que o tableView deve mostrar em tempo de execução
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaViagens.count
    }
    
    // Método obrigatório onde devemos informar o conteúdo que a célula do tableView deve mostrar
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        let viagemAtual = listaViagens[indexPath.row]
        
        cell.labelTitulo.text = viagemAtual.titulo
        cell.labelQuantidadeDeDias.text = "\(viagemAtual.quantidadeDeDias) dias"
        cell.labelPreco.text = viagemAtual.preco
        cell.imagemViagem.image = UIImage(named: viagemAtual.caminhoDaImagem)
        
        // comandos para deixar a imagem de cada célula com os cantos arredondados.
        cell.imagemViagem.layer.cornerRadius = 10
        cell.imagemViagem.layer.masksToBounds = true
        
        return cell
    }
    
    // Método do UITableViewDelegate, e usamos para configurar a altura das celulas do Table View
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
}

