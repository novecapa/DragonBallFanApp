//
//  SwiftDataError.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 5/2/25.
//


enum SwiftDataError: Error {
    case errorSave(String)
    case errorFetch(String)
    case errorSearch(String)
    case errorDelete(String)
}