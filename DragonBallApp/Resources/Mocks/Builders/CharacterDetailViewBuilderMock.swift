//
//  CharacterDetailViewBuilderMock.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 5/2/25.
//  
//

import Foundation

final class CharacterDetailViewBuilderMock: CharacterDetailViewBuilderProtocol {
	func build() -> CharacterDetailView {
        // let useCase = CharacterDetailUseCaseMock()
		let viewModel = CharacterDetailViewModel()
        let view = CharacterDetailView(viewModel: viewModel)
		return view
	}
}
