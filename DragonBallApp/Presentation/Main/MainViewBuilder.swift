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
		let storyboard = UIStoryboard(name: MainViewController.identifier,
                                      bundle: Bundle.main)
		let vController = storyboard.instantiateViewController(withIdentifier: MainViewController.identifier)
		if let viewController = vController as? MainViewController {
			let router = MainViewRouter(viewController: viewController)
			let viewModel = MainViewModel(router: router)

			viewController.viewModel = viewModel

			return viewController
		} else {
			return MainViewController()
		}
	}
}
