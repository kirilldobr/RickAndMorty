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
