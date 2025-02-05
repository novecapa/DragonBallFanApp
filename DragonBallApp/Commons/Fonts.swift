//
//  Fonts.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 5/2/25.
//

import UIKit
import SwiftUI

enum Fonts {

    case bold(CGFloat)
    case light(CGFloat)
    case medium(CGFloat)
    case regular(CGFloat)

    var uiFont: UIFont {
        switch self {
        case .bold(let size):
            return UIFont.init(name: "NotoSans-Bold", size: size) ?? UIFont.systemFont(ofSize: size)
        case .light(let size):
            return UIFont.init(name: "NotoSans-Light", size: size) ?? UIFont.systemFont(ofSize: size)
        case .medium(let size):
            return UIFont.init(name: "NotoSans-Medium", size: size) ?? UIFont.systemFont(ofSize: size)
        case .regular(let size):
            return UIFont.init(name: "NotoSans-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
        }
    }
}
// MARK: - UIKit Font
extension UIFont {
    static func notoSans(_ style: Fonts) -> UIFont {
        style.uiFont
    }
}
// MARK: - SwiftUI Font
extension Font {
   static func notoSans(_ style: Fonts) -> Font {
       Font(style.uiFont)
   }
}
