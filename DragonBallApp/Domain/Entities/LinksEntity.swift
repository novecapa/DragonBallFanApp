//
//  LinksEntity.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 5/2/25.
//

struct LinksEntity {
    let first: String
    let previous: String
    let next: String
    let last: String

    static let empty: LinksEntity = LinksEntity(
        first: "",
        previous: "",
        next: "",
        last: ""
    )
}
