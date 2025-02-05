//
//  MainViewModel.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 5/2/25.
//  
//

import Foundation

final class MainViewModel {

	private let router: MainViewRouterProtocol

	required init(router: MainViewRouterProtocol) {
		self.router = router
	}
}

extension MainViewModel: MainViewModelProtocol {

    func viewReady() {
        // Called when view is loaded and ready
    }

    func viewDidAppear() {

    }
}
