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
        Text("FavoritesView")
    }
}

#Preview {
    FavoritesViewBuilderMock().build()
}
