//
//  CustomSplashViewBuilder.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 5/2/25.
//  
//

import Foundation
import UIKit

final class CustomSplashBuilder: CustomSplashViewBuilderProtocol {
	func build() -> CustomSplashViewController {
        let viewController = CustomSplashViewController()
        let router = CustomSplashViewRouter(viewController: viewController)
        let viewModel = CustomSplashViewModel(router: router)
        viewController.viewModel = viewModel
        return viewController
	}
}
