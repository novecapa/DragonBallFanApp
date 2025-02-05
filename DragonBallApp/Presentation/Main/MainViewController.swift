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

    // MARK: - Init

    init() {
        super.init(nibName: nil, bundle: Bundle(for: MainViewController.self))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = .white
    }

    private func setupView() {
        // TODO: -
//        let splash = CustomSplashBuilder().build()
//        let splashTab = UINavigationController(rootViewController: splash)
//        splashTab.tabBarItem = UITabBarItem(title: nil,
//                                            image: UIImage(systemName: "rectangle.stack.person.crop"),
//                                            selectedImage: UIImage(systemName: "rectangle.stack.person.crop.fill"))
//
//        let splash2 = CustomSplashBuilder().build()
//        let splashTab2 = UINavigationController(rootViewController: splash2)
//        splashTab2.tabBarItem = UITabBarItem(title: nil,
//                                             image: UIImage(systemName: "star"),
//                                             selectedImage: UIImage(systemName: "star.fill"))
//
//        self.viewControllers = [splashTab, splashTab2]
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
