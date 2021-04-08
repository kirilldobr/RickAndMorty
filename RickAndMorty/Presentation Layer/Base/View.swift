//
//  View.swift
//  RickAndMorty
//
//  Created by Kirill Dobryakov on 08.04.2021.
//

import RxCocoa
import RxSwift
import UIKit

class BaseView<Model: ViewModel>: UIView, HasViewModel, HasDisposeBag {
    let aliveDisposeBag = DisposeBag()
    var disposeBag = DisposeBag()
    
    func setModel(_: Model) {
        disposeBag = DisposeBag()
    }
    
    func didLoad() {}
    
    required convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        didLoad()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

