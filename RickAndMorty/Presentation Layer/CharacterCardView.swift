//
//  CharacterCardView.swift
//  RickAndMorty
//
//  Created by Kirill Dobryakov on 08.04.2021.
//

import Foundation
import UIKit
import EasyPeasy
import RxSwift
import Kingfisher

class CharacterCardViewModel: ViewModel {
    let character: Character
    let name: String
    let imageURL: String
    
    init(character: Character) {
        self.character = character
        name = character.name
        imageURL = character.imageURL
    }
}


class CharacterCardView: BaseView<CharacterCardViewModel> {
    let nameLabel = UILabel()
    
    override func setModel(_ model: CharacterCardViewModel) {
        super.setModel(model)
        
        nameLabel.text = model.name
    }
    
    
    override func didLoad() {
        super.didLoad()
        
        addSubview(nameLabel, layout: Edges())
    }
}
