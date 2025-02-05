//
//  CharacterDetailViewModel.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 5/2/25.
//  
//

import SwiftUI

final class CharacterDetailViewModel: ObservableObject {

    private let useCase: CharactersUseCaseProtocol

    init(useCase: CharactersUseCaseProtocol) {
        self.useCase = useCase
    }
}
