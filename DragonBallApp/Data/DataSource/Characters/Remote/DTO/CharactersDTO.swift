//
//  CharactersDTO.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 4/2/25.
//

// MARK: - CharactersDTO
struct CharactersDTO: Codable {
    let items: [ItemDTO]
    let meta: MetaDTO
    let links: LinksDTO
}

// MARK: - ItemDTO
struct ItemDTO: Codable {
    let id: Int
    let name: String
    let kii: String
    let maxKi: String
    let race: String
    let gender: GenderDTO
    let description: String
    let image: String
    let affiliation: String

    enum CodingKeys: String, CodingKey {
        case id, name, maxKi, race, gender, description, image, affiliation
        case kii = "ki"
    }
}

enum GenderDTO: String, Codable {
    case female = "Female"
    case male = "Male"
}

// MARK: - LinksDTO
struct LinksDTO: Codable {
    let first: String
    let previous: String
    let next: String
    let last: String
}

// MARK: - MetaDTO
struct MetaDTO: Codable {
    let totalItems: Int
    let itemCount: Int
    let itemsPerPage: Int
    let totalPages: Int
    let currentPage: Int
}
