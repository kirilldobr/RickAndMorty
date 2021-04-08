//
//  AliveStatusView.swift
//  RickAndMorty
//
//  Created by Kirill Dobryakov on 08.04.2021.
//

import Foundation

import EasyPeasy
import UIKit

class AliveStatusViewModel: ViewModel {
    let statusText: String
    let statusColor: UIColor
    
    init(status: AliveStatus) {
        statusText = status.rawValue.uppercased()
        
        switch status {
        case .alive: statusColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        case .dead: statusColor = .red
        case .unknown: statusColor = .gray
        }
    }
}

class AliveStatusView: BaseView<AliveStatusViewModel> {
    let label = UILabel()
    
    override func didLoad() {
        super.didLoad()
        
        addSubview(label, layout: Edges(5))
    }
    
    override func setModel(_ model: AliveStatusViewModel) {
        label.text = model.statusText
        backgroundColor = model.statusColor
        layer.cornerRadius = 5
        layer.masksToBounds = true
    }
}
