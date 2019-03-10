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
        
        celulaPacote.configuraCelula(pacoteAtual)
        
        return celulaPacote
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return UIDevice.current.userInterfaceIdiom == .phone ? CGSize(width: collectionView.bounds.width / 2-20, height: 160) : CGSize(width: collectionView.bounds.width / 3-20, height: 250)
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
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
    // Método do protocolo UISearchBarDelegate responsável por filtrar a lista de pacotes de acordo com o que o usuário digitar no searchBar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        listaViagens = listaComTodasViagens
        if searchText != "" {
            
            // NSPredicate é uma classe do Objective-C, portanto tive que adicionar o código "@objc" na definição do campo titulo lá na classe Viagem.swift, pois senão o compilador apontava erro. A sintaxe [cd] logo após o contains significa que é para o filtro ignorar case sensitive(c) e acentuação(d)
            listaViagens = listaViagens.filter({$0.viagem.titulo.contains(searchText)})
        }
        
        self.labelContadorPacotes.text = self.atualizaContadorLabel()
        ColecaoPacotesViagem.reloadData()
    }

    func atualizaContadorLabel() -> String{
        return listaViagens.count == 1 ? "1 pacote encontrado" : "\(listaViagens.count) pacotes encontrados"
    }

}
