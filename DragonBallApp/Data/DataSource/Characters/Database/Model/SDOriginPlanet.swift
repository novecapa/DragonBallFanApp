//
//  SDOriginPlanet.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 6/2/25.
//

import Foundation
import SwiftData

@Model
final class SDOriginPlanet {
    @Attribute(.unique) var id: Int
    var name: String
    var isDestroyed: Bool
    var desc: String
    var image: String

    @Relationship(inverse: \SDCharacter.originPlanet)
    var characters: [SDCharacter] = []

    init(
        id: Int,
        name: String,
        isDestroyed: Bool,
        desc: String,
        image: String,
        characters: [SDCharacter] = []
    ) {
        self.id = id
        self.name = name
        self.isDestroyed = isDestroyed
        self.desc = desc
        self.image = image
        self.characters = characters
    }
}
