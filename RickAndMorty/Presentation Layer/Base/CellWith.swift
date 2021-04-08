//
//  CellWith.swift
//  RickAndMorty
//
//  Created by Kirill Dobryakov on 08.04.2021.
//

import Foundation
import EasyPeasy
import RxCocoa
import RxSwift
import UIKit

typealias ViewWithModel = UIView & HasViewModel

class CellWith<V: ViewWithModel>: UITableViewCell, HasAnyViewModel, HasReuseID {
    static var cellReuseIdentifier: String {
        return String(describing: V.Model.self)
    }
    
    private var innerView = V()
    
    let aliveDisposeBag = DisposeBag()
    var disposeBag = DisposeBag()
    
    func setAnyModel(_ model: Any) {
        guard let myModel = model as? V.Model else { return }
        
        innerView.setModel(myModel)
    }
    
    func didLoad() {
        selectionStyle = .none
        contentView.backgroundColor = .clear
        
        backgroundColor = .clear
        
        contentView.addSubview(innerView, layout: Edges())
    }
    
    convenience init() {
        self.init(style: .default, reuseIdentifier: nil)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        didLoad()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
