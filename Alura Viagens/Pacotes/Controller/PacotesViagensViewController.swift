//
//  PacotesViagensViewController.swift
//  Alura Viagens
//
//  Created by Mauro Augusto Diniz on 03/03/19.
//  Copyright © 2019 Mauro Augusto Diniz. All rights reserved.
//

import UIKit

// Implementando o protocolo UICollectionViewDataSource, para que eu tenha acesso aos metodos que dizem à viewCollection quantos ele deve exibir e renderizar.
// UISearchBarDelegate -> protocolo com uma variedade de métodos que precisamos implementar para fazer a search bar funcionar.
// UICollectionViewDelegate -> Protocolo que me permite manipular os itens de um collectionView, por exemplo para clicar em 1 item e mostrar uma tela específica do item clicado.
class PacotesViagensViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, UICollectionViewDelegate {

    @IBOutlet weak var ColecaoPacotesViagem: UICollectionView!
    
    @IBOutlet weak var pesquisarViagens: UISearchBar!
    
    @IBOutlet weak var labelContadorPacotes: UILabel!
    
    let listaComTodasViagens: Array<PacoteViagem> = PacoteViagemDAO().retornaTodasAsViagens()
    var listaViagens: Array<PacoteViagem> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listaViagens = listaComTodasViagens
        ColecaoPacotesViagem.dataSource = self
        ColecaoPacotesViagem.delegate = self
        pesquisarViagens.delegate = self
        self.labelContadorPacotes.text = self.atualizaContadorLabel()

        // Do any additional setup after loading the view.
    }
    
    // Método obrigatório do protocolo UICollectionViewDataSource, responsavel por retornar a quantidade de itens(células) que a collection vai renderizar
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listaViagens.count
    }
    
    // Método obrigatório do protocolo UICollectionViewDataSource, responsavel por retornar o conteudo que o item da collectionView deve exibir
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celulaPacote = collectionView.dequeueReusableCell(withReuseIdentifier: "celulaPacote", for: indexPath) as! PacoteViagemCollectionViewCell
        
        let pacoteAtual = listaViagens[indexPath.item]
        
        celulaPacote.labelTitulo.text = pacoteAtual.viagem.titulo
        celulaPacote.labelQuantidadeDias.text = "\(pacoteAtual.viagem.quantidadeDeDias) dias"
        celulaPacote.labelPreco.text = "R$\(pacoteAtual.viagem.preco)"
        celulaPacote.imagemViagem.image = UIImage(named: pacoteAtual.viagem.caminhoDaImagem)
        
        // setando a borda e o arredondamento da célula, pois por padrão estava transparente e sem arredondamento
        celulaPacote.layer.borderWidth = 0.5
        celulaPacote.layer.borderColor = UIColor(red: 85.0/255.0, green: 85.0/255.0, blue: 85.0/255.0, alpha: 1).cgColor
        celulaPacote.layer.cornerRadius = 8
        
        return celulaPacote
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let larguraCelula = (collectionView.bounds.width / 2) - 15
        
        
        return CGSize(width: larguraCelula, height: 160)
    }
    
    // Método do protocolo UICollectionViewDelegate onde podemos executar algo após o usuário clicar em um item da collectionView. Nesse caso chamei a tela de detalhes da Viagem.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // setando o item selecionado
        let pacote = listaViagens[indexPath.item]
        // Setando o storyboard onde o view controller está
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        // Setando qual viewController desejo mostrar através do identificador
        let controller = storyboard.instantiateViewController(withIdentifier: "detalhes") as! DetalhesViagensViewController
        controller.pacoteSelecionado = pacote
        // mostrando o controller
        self.present(controller, animated: true, completion: nil)
    }
    
    
    // Método do protocolo UISearchBarDelegate responsável por filtrar a lista de pacotes de acordo com o que o usuário digitar no searchBar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        listaViagens = listaComTodasViagens
        if searchText != "" {
            
            // NSPredicate é uma classe do Objective-C, portanto tive que adicionar o código "@objc" na definição do campo titulo lá na classe Viagem.swift, pois senão o compilador apontava erro. A sintaxe [cd] logo após o contains significa que é para o filtro ignorar case sensitive(c) e acentuação(d)
            let filtroListaViagem = NSPredicate(format: "titulo contains[cd] %@", searchText)
            let listaFiltrada:Array<PacoteViagem> = (listaViagens as NSArray).filtered(using: filtroListaViagem) as! Array
            listaViagens = listaFiltrada
        }
        
        self.labelContadorPacotes.text = self.atualizaContadorLabel()
        ColecaoPacotesViagem.reloadData()
    }

    func atualizaContadorLabel() -> String{
        return listaViagens.count == 1 ? "1 pacote encontrado" : "\(listaViagens.count) pacotes encontrados"
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
