//
//  MainViewController.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 5/2/25.
//

import Foundation
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = .white
    }

    private func setupView() {
        let charactersView = CharactersViewBuilder().build()
        let characterController = HostingController(rootView: charactersView)
        let charactersTab = UINavigationController(rootViewController: characterController)
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
