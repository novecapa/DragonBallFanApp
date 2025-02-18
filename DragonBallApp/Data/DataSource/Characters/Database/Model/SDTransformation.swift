//
//  SDTransformation.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 6/2/25.
//

import Foundation
import SwiftData

@Model
final class SDTransformation {
    var id: Int
    var name: String
    var image: String
    var kii: String

    @Relationship(deleteRule: .cascade, inverse: \SDCharacter.transformations)
    var character: SDCharacter?

    init(
        id: Int,
        name: String,
        image: String,
        kii: String
    ) {
        self.id = id
        self.name = name
        self.image = image
        self.kii = kii
    }
}
