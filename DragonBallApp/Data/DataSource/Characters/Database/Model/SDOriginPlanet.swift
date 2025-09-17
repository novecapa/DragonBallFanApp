//
//  SDOriginPlanet.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 6/2/25.
//

import Foundation
import SwiftData

@Model
final class SDOriginPlanet: Sendable {
    var id: Int
    var name: String
    var isDestroyed: Bool
    var desc: String
    var image: String

    init(
        id: Int,
        name: String,
        isDestroyed: Bool,
        desc: String,
        image: String
    ) {
        self.id = id
        self.name = name
        self.isDestroyed = isDestroyed
        self.desc = desc
        self.image = image
    }
}
