//
//  Extensions.swift
//  RickAndMorty
//
//  Created by Kirill Dobryakov on 08.04.2021.
//

import Foundation
import UIKit
import EasyPeasy

extension UIView {
    func addSubview(_ view: UIView, layout attributes: Attribute...) {
        addSubview(view)
        view.easy.layout(attributes)
    }
}


extension UITableView {
    static let globalAssociation: [IsTableCellWithReuseID.Type] = [
        
    ]
    
    func register(cellClass: IsTableCellWithReuseID.Type) {
        register(cellClass.self, forCellReuseIdentifier: cellClass.cellReuseIdentifier)
    }
}
