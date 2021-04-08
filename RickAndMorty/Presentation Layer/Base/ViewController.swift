//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Kirill Dobryakov on 08.04.2021.
//

import EasyPeasy
import RxSwift
import UIKit

class ViewController<Model: ViewModel>: UIViewController, HasViewModel, HasDisposeBag {
    let aliveDisposeBag = DisposeBag()
    var disposeBag = DisposeBag()
    
    func setModel(_: Model) {
        disposeBag = DisposeBag()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}
