//
//  MainViewRouter.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 5/2/25.
//  
//

import Foundation
import UIKit

final class MainViewRouter {
	private weak var viewController: UIViewController?

	required init(viewController: UIViewController?) {
        self.viewController = viewController
    }
}

extension MainViewRouter: MainViewRouterProtocol {
    func showCharacterDetail(for id: Int, from navigation: UINavigationController) {
        DispatchQueue.main.async {
            let detailView = CharacterDetailViewBuilder().build(characterId: id)
            let controller = HostingController(isTabBarHidden: true, rootView: detailView)
            navigation.pushViewController(controller, animated: true)
        }
    }
}
