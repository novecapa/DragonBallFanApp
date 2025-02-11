//
//  CustomSplashViewRouter.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 5/2/25.
//

import Foundation
import UIKit

final class CustomSplashViewRouter {

    private weak var viewController: UIViewController?

    required init(viewController: UIViewController?) {
        self.viewController = viewController
    }
}
// MARK: - CustomSplashViewRouterProtocol
extension CustomSplashViewRouter: CustomSplashViewRouterProtocol {
    func showMainView() {
        DispatchQueue.main.async {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let sceneDelegate = windowScene.delegate as? SceneDelegate else {
                return
            }
            let mainViewControler = MainBuilder().build()
            sceneDelegate.window?.rootViewController = mainViewControler
            sceneDelegate.window?.rootViewController?.modalPresentationStyle = .fullScreen
            sceneDelegate.window?.overrideUserInterfaceStyle = .light
            sceneDelegate.window?.backgroundColor = .white
            UIView.animate(withDuration: 0.25, animations: {
                sceneDelegate.window?.makeKeyAndVisible()
            })
        }
    }
}
