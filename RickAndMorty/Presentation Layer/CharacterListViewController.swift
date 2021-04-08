//
//  CharacterListViewController.swift
//  RickAndMorty
//
//  Created by Kirill Dobryakov on 08.04.2021.
//

import EasyPeasy
import RxCocoa
import RxSwift
import UIKit

class CharacterListViewModel: TableViewModel {
    
    override init() {
        super.init()
        
        var nextPageUrl: String? = Endpoint.characters(for: 1)
        
        pullToRefresh
            .do(onNext: {
                nextPageUrl = Endpoint.characters(for: 1)
            })
            .flatMapLatest { NetworkManager.shared.getCharacters(urlString: nextPageUrl) }
            .subscribe(onNext: { [weak self] info in
                self?.isRefreshing.accept(false)
                self?.elements.accept([])
                
                nextPageUrl = info.info.nextPageURL
                
                let characterCardModels = info.characters.map { character in CharacterCardViewModel(character: character) }
                self?.elements.accept(characterCardModels)
            }, onError: { [weak self] error in
                self?.isRefreshing.accept(false)
                self?.elements.accept([])
            })
            .disposed(by: aliveDisposeBag)
        
        reachedBottom
            .flatMapLatest { NetworkManager.shared.getCharacters(urlString: nextPageUrl) }
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] info in
                nextPageUrl = info.info.nextPageURL
                
                let characterCardModels = info.characters.map { character in CharacterCardViewModel(character: character) }
                self?.elements.accept((self?.elements.value ?? []) + characterCardModels)
            })
            .disposed(by: aliveDisposeBag)
    }
}


class CharacterListViewController: ViewController<CharacterListViewModel> {
    let tableView = TableView<TableViewModel>()
    
    override func setModel(_ viewModel: CharacterListViewModel) {
        super.setModel(viewModel)
        
        tableView.setModel(viewModel)
        
        viewModel.modelSelected
            .observeOn(MainScheduler())
            .bind { [weak self] vm in
                guard let characterCardViewModel = vm as? CharacterCardViewModel else { return }
                
                let characterDetailViewModel = CharacterDetailViewModel(character: characterCardViewModel.character)
                let characterDetailViewController = CharacterDetailViewController(viewModel: characterDetailViewModel)
                
                self?.navigationController?.pushViewController(characterDetailViewController, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Characters"
        
        view.addSubview(tableView, layout: Edges())
    }
}

