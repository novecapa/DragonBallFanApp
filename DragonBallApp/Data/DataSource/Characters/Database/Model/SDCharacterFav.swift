//
//  SDCharacterFav.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 10/2/25.
//

import Foundation
import SwiftData

@Model
final class SDCharacterFav {
    @Attribute(.unique) var characterId: Int

    init(characterId: Int) {
        self.characterId = characterId
    }
}
