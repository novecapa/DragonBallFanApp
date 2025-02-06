//
//  Images.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 6/2/25.
//

import UIKit
import SwiftUI

enum Images {

    case splash
    case cardBackground

    var uiImage: UIImage? {
        switch self {
        case .splash:
            return UIImage(named: "splash")
        case .cardBackground:
            return UIImage(named: "cardBackground")
        }
    }
}
// MARK: - UIImage
extension UIImage {
    static func load(_ img: Images) -> UIImage? {
        img.uiImage
    }
}

extension Image {
    static func cardBackground() -> Image {
        Image("cardBackground")
    }
}
