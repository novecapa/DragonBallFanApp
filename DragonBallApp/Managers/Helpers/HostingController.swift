//
//  HostingController.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 5/2/25.
//

import SwiftUI

final class HostingController<Content: View>: UIHostingController<Content> {

    private let isNavigationBarHidden: Bool
    private let isTabBarHidden: Bool

    init(isNavigationBarHidden: Bool = false,
         isTabBarHidden: Bool = false,
         rootView: Content) {
        self.isNavigationBarHidden = isNavigationBarHidden
        self.isTabBarHidden = isTabBarHidden
        super.init(rootView: rootView)
    }

    required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = isNavigationBarHidden
        tabBarController?.tabBar.isHidden = isTabBarHidden
    }
}
