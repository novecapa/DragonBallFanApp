//
//  FavoritesView.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 5/2/25.
//  
//

import SwiftUI

struct FavoritesView: View {

	@ObservedObject var viewModel: FavoritesViewModel

    var body: some View {
        ZStack {
            GeometryReader { _ in

            }
        }
        .onAppear {
            viewModel.getFavorites()
        }
    }
}

#Preview {
    FavoritesViewBuilderMock().build()
}
