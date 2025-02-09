//
//  SDCharacterFav.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 9/2/25.
//

import Foundation
import SwiftData

@Model
final class SDCharacterFav {
    @Attribute(.unique) var id: Int
    init(id: Int) {
        self.id = id
    }
}
