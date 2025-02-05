//
//  FavoritesViewBuilder.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 5/2/25.
//  
//

import Foundation

protocol FavoritesViewBuilderProtocol {
	func build() -> FavoritesView
}

final class FavoritesViewBuilder: FavoritesViewBuilderProtocol {
	func build() -> FavoritesView {
        // let useCase = FavoritesUseCase()
		let viewModel = FavoritesViewModel()
        let view = FavoritesView(viewModel: viewModel)
		return view
	}
}
