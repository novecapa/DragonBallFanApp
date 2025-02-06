//
//  SceneDelegate.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 4/2/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)

        let viewController: UIViewController = CustomSplashBuilder().build()
        window.rootViewController = viewController
        window.rootViewController?.modalPresentationStyle = .fullScreen
        window.overrideUserInterfaceStyle = .light
        window.backgroundColor = .white

        self.window = window
        setupDefaultAppearances()

        UIView.animate(withDuration: 0.25, animations: {
            window.makeKeyAndVisible()
        })
    }

    private func setupDefaultAppearances() {
        window?.tintColor = .dbYellow
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}
