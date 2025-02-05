//
//  MainViewBuilder.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 5/2/25.
//  
//

import Foundation
import UIKit

final class MainBuilder: MainViewBuilderProtocol {
	func build() -> MainViewController {
        let viewController = MainViewController()
        let router = MainViewRouter(viewController: viewController)
        let viewModel = MainViewModel(router: router)
        viewController.viewModel = viewModel
        return viewController
	}
}
