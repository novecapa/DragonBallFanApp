//
//  MainViewController.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 5/2/25.
//

import Foundation
import SwiftUI
import UIKit

final class MainViewController: UITabBarController {

    var viewModel: MainViewModelProtocol!

    init() {
        super.init(nibName: nil, bundle: Bundle(for: MainViewController.self))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        let charactersTab = UINavigationController()
        let charactersView = CharactersViewBuilder().build { characterId in
            charactersTab.title = nil
            self.viewModel.showCharacterDetail(for: characterId, from: charactersTab)
        }
        let characterController = HostingController(rootView: charactersView)
        characterController.navigationItem.backButtonTitle = ""
        charactersTab.viewControllers = [characterController]
        charactersTab.tabBarItem = UITabBarItem(title: nil,
                                                image: UIImage(systemName: "rectangle.stack.person.crop"),
                                                selectedImage: UIImage(systemName: "rectangle.stack.person.crop.fill"))

        let favoritesView = FavoritesViewBuilder().build()
        let favoritesController = HostingController(rootView: favoritesView)
        let favoritesTab = UINavigationController(rootViewController: favoritesController)
        favoritesTab.tabBarItem = UITabBarItem(title: nil,
                                               image: UIImage(systemName: "star"),
                                               selectedImage: UIImage(systemName: "star.fill"))

        self.viewControllers = [charactersTab, favoritesTab]
        self.selectedIndex = 0
        self.modalPresentationStyle = .currentContext
        self.delegate = self
    }
}

// MARK: - UITabBarControllerDelegate
extension MainViewController: UITabBarControllerDelegate {
   override func tabBar(_ tabBar: UITabBar, willBeginCustomizing items: [UITabBarItem]) {}

   func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {}

   func tabBarController(_ tabBarController: UITabBarController,
                         shouldSelect viewController: UIViewController) -> Bool {

       if viewControllers?.firstIndex(of: viewController) == nil {
           return false
       }
       return true
   }

   override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {}
}
