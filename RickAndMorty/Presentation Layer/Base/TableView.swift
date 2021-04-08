//
//  TableView.swift
//  RickAndMorty
//
//  Created by Kirill Dobryakov on 08.04.2021.
//

import EasyPeasy
import RxCocoa
import RxDataSources
import RxSwift
import RxSwiftExt
import UIKit

typealias IsTableCellWithReuseID = HasReuseID & UITableViewCell

class TableViewModel: ViewModel, ViewModelDataSource {
    let elements = BehaviorRelay<[ViewModel]>(value: [])
    
    let modelSelected = PublishRelay<ViewModel>()
    
    let reachedBottom = PublishRelay<Void>()
    
    let pullToRefresh = PublishRelay<Void>()
    
    let isRefreshing = PublishRelay<Bool>()
}

class TableView<Model: TableViewModel>: BaseView<Model> {
    private let tableView = UITableView(frame: CGRect.zero, style: .plain)
    
    private let refreshControl = UIRefreshControl()
    
    override func didLoad() {
        super.didLoad()
        
        tableView.backgroundColor = .white
        
        addSubview(tableView, layout: Edges())
    
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        tableView.addSubview(refreshControl)
    }
    
    override func setModel(_ viewModel: Model) {
        super.setModel(viewModel)
        
        UITableView.globalAssociation.forEach { tableView.register(cellClass: $0) }
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, ViewModel>>(configureCell: { (_, tableView, indexPath, model) -> UITableViewCell in
            
            let cellReuseIdentifier = String(describing: type(of: model))
            let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
            
            guard let Cell = cell as? HasAnyViewModel else { return cell }
            
            Cell.setAnyModel(model)
            return cell
        })
        
        tableView.rx.modelSelected(type(of: viewModel.elements.value).Element.self)
            .bind(to: viewModel.modelSelected)
            .disposed(by: disposeBag)
        
        viewModel.elements
            .map { [SectionModel<String, ViewModel>(model: "", items: $0)] }
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        tableView.rx.reachedBottom()
            .bind(to: viewModel.reachedBottom)
            .disposed(by: disposeBag)
        
        refreshControl.rx.controlEvent(.valueChanged)
            .debug()
            .bind(to: viewModel.pullToRefresh)
            .disposed(by: disposeBag)
        
        viewModel.isRefreshing
            .observeOn(MainScheduler())
            .filter { !$0 }
            .bind { [weak self] _ in
                self?.refreshControl.endRefreshing()
            }
            .disposed(by: disposeBag)
    }
}
