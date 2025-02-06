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
}
