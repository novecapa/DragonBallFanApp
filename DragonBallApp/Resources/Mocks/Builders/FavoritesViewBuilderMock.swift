//
//  FavoritesViewBuilderMock.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 5/2/25.
//  
//

import Foundation

final class FavoritesViewBuilderMock: FavoritesViewBuilderProtocol {
	func build() -> FavoritesView {
        // let useCase = FavoritesUseCaseMock()
		let viewModel = FavoritesViewModel()
        let view = FavoritesView(viewModel: viewModel)
		return view
	}
}
