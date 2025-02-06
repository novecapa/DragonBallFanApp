//
//  Endpoints.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 4/2/25.
//

import Foundation

enum Endpoints {

    private static let baseURL = "https://dragonball-api.com/api/"

    case characters

    var rawValue: String {
        switch self {
        case .characters:
            return Endpoints.baseURL + "characters"
        }
    }
}
