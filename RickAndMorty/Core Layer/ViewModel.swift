//
//  ViewModel.swift
//  RickAndMorty
//
//  Created by Kirill Dobryakov on 08.04.2021.
//

import RxSwift
import RxCocoa

class ViewModel: HasDisposeBag {
    let aliveDisposeBag = DisposeBag()
    var disposeBag = DisposeBag()
}

protocol HasViewModel {
    associatedtype Model: ViewModel
    
    func setModel(_ viewModel: Model)
    
    init()
    init(viewModel: Model)
}

extension HasViewModel {
    init(viewModel: Model) {
        self.init()
        setModel(viewModel)
    }
}

protocol HasAnyViewModel {
    func setAnyModel(_ model: Any)
}

protocol HasDisposeBag {
    var disposeBag: DisposeBag { get set }
    var aliveDisposeBag: DisposeBag { get }
}

protocol HasReuseID {
    static var cellReuseIdentifier: String { get }
}

extension HasReuseID where Self: HasViewModel {
    static var cellReuseIdentifier: String {
        return String(describing: Model.self)
    }
}

protocol ViewModelDataSource {
    associatedtype VM
    
    var elements: BehaviorRelay<[VM]> { get }
}


