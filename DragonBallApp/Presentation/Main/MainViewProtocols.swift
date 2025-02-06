//
//  MainViewProtocols.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 5/2/25.
//  
//

import UIKit

protocol MainViewModelProtocol {
    func viewReady()
    func viewDidAppear()
    func showCharacterDetail(for id: Int, from navigation: UINavigationController)
}

protocol MainViewRouterProtocol {
    func showCharacterDetail(for id: Int, from navigation: UINavigationController)
}

protocol MainViewBuilderProtocol {
    func build() -> MainViewController
}
