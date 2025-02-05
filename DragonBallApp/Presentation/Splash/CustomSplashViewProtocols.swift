//
//  CustomSplashViewProtocols.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 5/2/25.
//  
//

import Foundation

protocol CustomSplashViewModelProtocol {
    var appVersion: String { get }
    func showMainView()
}

protocol CustomSplashViewRouterProtocol {
    func showMainView()
}

protocol CustomSplashViewBuilderProtocol {
    func build() -> CustomSplashViewController
}
