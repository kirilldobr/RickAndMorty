//
//  CharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Kirill Dobryakov on 08.04.2021.
//

import Foundation

import EasyPeasy
import RxCocoa
import RxSwift
import UIKit


class CharacterDetailViewModel: ViewModel {
    let name: String
    let imageURL: String
    let aliveStatusViewModel: AliveStatusViewModel
    
    init(character: Character) {
        name = character.name
        imageURL = character.imageURL
        aliveStatusViewModel = AliveStatusViewModel(status: character.aliveStatus)
    }
}

class CharacterDetailViewController: ViewController<CharacterDetailViewModel> {
    let nameLabel = UILabel()
    let imageView = UIImageView()
    let aliveStatusView = AliveStatusView()
    
    override func setModel(_ model: CharacterDetailViewModel) {
        nameLabel.text = model.name
        imageView.kf.setImage(with: URL(string: model.imageURL))
        aliveStatusView.setModel(model.aliveStatusViewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scrollView = UIScrollView()
        let containerView = UIView()
        
        view.addSubview(scrollView, layout: Edges())
        scrollView.addSubview(containerView, layout: Edges(), Width().like(scrollView, .width))
        
        containerView.addSubview(imageView, layout: Top(16), CenterX(), Size(200))
        containerView.addSubview(nameLabel, layout: Top(8).to(imageView), Left(8), Right(8))
        containerView.addSubview(aliveStatusView, layout: Top(8).to(nameLabel), CenterX())
        
        scrollView.alwaysBounceVertical = true
        imageView.contentMode = .scaleAspectFill
        nameLabel.textColor = .black
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 0
    }
}

