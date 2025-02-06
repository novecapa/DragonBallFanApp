//
//  MainViewModel.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 5/2/25.
//  
//

import UIKit

final class MainViewModel {

	private let router: MainViewRouterProtocol

	required init(router: MainViewRouterProtocol) {
		self.router = router
	}
}

extension MainViewModel: MainViewModelProtocol {
    func viewReady() {}

    func viewDidAppear() {}

    func showCharacterDetail(for id: Int, from navigation: UINavigationController) {
        router.showCharacterDetail(for: id, from: navigation)
    }
}
