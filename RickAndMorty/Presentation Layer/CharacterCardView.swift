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
    let imageView = UIImageView()
    
    override func setModel(_ model: CharacterCardViewModel) {
        nameLabel.text = model.name
        imageView.kf.setImage(with: URL(string: model.imageURL))
    }
    
    override func didLoad() {
        super.didLoad()
        
        addSubview(imageView, layout: CenterY(), Left(8), Size(60))
        
        addSubview(nameLabel, layout: Left(8).to(imageView), CenterY(), Right(8))
            
        imageView.contentMode = .scaleAspectFill
        nameLabel.textColor = .black
        nameLabel.numberOfLines = 0
    }
}


