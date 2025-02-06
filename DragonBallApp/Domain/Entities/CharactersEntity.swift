//
//  CharactersEntity.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 5/2/25.
//

import Foundation

// MARK: - CharactersEntity
struct CharactersEntity {
    let character: [CharacterEntity]
    let links: LinksEntity

    var addNewPage: Int {
        links.next.isEmpty ? 0 : 1
    }
}

// MARK: - CharacterEntity
struct CharacterEntity: Hashable {
    let id: Int
    let name: String
    let kii: String
    let maxKi: String
    let race: String
    let gender: String
    let description: String
    let image: String
    let affiliation: String
    let originPlanet: OriginPlanetEntity?
    let transformations: [TransformationEntity]?

    var imageURL: URL? {
        URL(string: self.image)
    }

    var raceGender: String {
        "\(race) - \(gender)"
    }
}

// MARK: - OriginPlanetEntity
struct OriginPlanetEntity: Hashable {
    let id: Int
    let name: String
    let isDestroyed: Bool
    let description: String
    let image: String
}

// MARK: - TransformationEntity
struct TransformationEntity: Hashable {
    let id: Int
    let name: String
    let image: String
    let kii: String
}
