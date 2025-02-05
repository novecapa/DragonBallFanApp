//
//  CustomSplashViewModel.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 5/2/25.
//  
//

import Foundation

final class CustomSplashViewModel {

    private let router: CustomSplashViewRouterProtocol
    private let utils: UtilsProtocol
    init(router: CustomSplashViewRouterProtocol,
         utils: UtilsProtocol = Utils()) {
        self.router = router
        self.utils = utils
    }
}

extension CustomSplashViewModel: CustomSplashViewModelProtocol {
    var appVersion: String {
        utils.appVersion
    }

    func showMainView() {
        router.showMainView()
    }
}
