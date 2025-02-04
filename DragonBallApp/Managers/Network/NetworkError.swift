//
//  NetworkError.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 4/2/25.
//

enum NetworkError: Error, Hashable {
    case badResponse
    case badRequest
    case serverError
    case badGateway
    case badURL
    case decodeError
}
