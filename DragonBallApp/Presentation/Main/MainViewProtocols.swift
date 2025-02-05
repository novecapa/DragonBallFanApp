//
//  MainViewProtocols.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 5/2/25.
//  
//

import Foundation

protocol MainViewModelProtocol {
    func viewReady()
    func viewDidAppear()
}

protocol MainViewRouterProtocol {
}

protocol MainViewBuilderProtocol {
    func build() -> MainViewController
}
