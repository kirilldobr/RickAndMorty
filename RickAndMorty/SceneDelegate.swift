//
//  SceneDelegate.swift
//  RickAndMorty
//
//  Created by Kirill Dobryakov on 08.04.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        NetworkManager.shared.getAllCharacters()
        
        let vc = UIViewController()
        vc.view.backgroundColor = .blue
        let navigationController = UINavigationController(rootViewController: vc)
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }



}

