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
    
}


class CharacterListViewcontroller: ViewController<CharacterListViewModel> {
    let tableView = TableView<TableViewModel>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Characters"
        
        view.addSubview(tableView, layout: Edges())
    }
}
