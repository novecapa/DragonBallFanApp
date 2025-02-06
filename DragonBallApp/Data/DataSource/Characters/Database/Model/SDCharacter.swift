//
//  SDCharacter.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 5/2/25.
//

import Foundation
import SwiftData

@Model
final class SDCharacter {
    @Attribute(.unique) var id: Int
    var name: String
    var kii: String
    var maxKi: String
    var race: String
    var gender: String
    var desc: String
    var image: String
    var affiliation: String

    @Relationship(deleteRule: .cascade)
    var originPlanet: SDOriginPlanet?

    @Relationship(deleteRule: .cascade)
    var transformations: [SDTransformation]?

    init(
        id: Int,
        name: String,
        kii: String,
        maxKi: String,
        race: String,
        gender: String,
        desc: String,
        image: String,
        affiliation: String,
        originPlanet: SDOriginPlanet?,
        transformations: [SDTransformation]?
    ) {
        self.id = id
        self.name = name
        self.kii = kii
        self.maxKi = maxKi
        self.race = race
        self.gender = gender
        self.desc = desc
        self.image = image
        self.affiliation = affiliation
        self.originPlanet = originPlanet
        self.transformations = transformations
    }
}
