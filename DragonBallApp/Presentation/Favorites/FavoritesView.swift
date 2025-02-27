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
    let visibleCardCount: Int = 2

    @State private var rotation: Int = 0
    var body: some View {

        ZStack {
            Color.dbBlack
                .edgesIgnoringSafeArea([.top, .leading, .trailing])
            GeometryReader { proxy in
                ForEach(rotatatedElements, id: \.id) { char in
                    let index = rotatatedElements.firstIndex(of: char) ?? 0
                                    let zIndex = Double(rotatatedElements.count - index)
                    CardStackView(index: index, count: rotatatedElements.count,
                                  visibleCardsCount: visibleCardCount,
                                  rotation: $rotation) {
                        FavoriteCardView(character: char, proxy: proxy)
                    }
                    .zIndex(zIndex)
                }
            }
            .padding(40)
        }
        .onAppear {
            viewModel.getFavorites()
        }
    }

    private var rotatatedElements: [CharacterEntity] {
        guard !viewModel.characters.isEmpty else { return [] }
        let count = viewModel.characters.count
        let moveToIndex = rotation % count
        return Array(
            viewModel.characters[moveToIndex...]
        ) + Array(
            viewModel.characters[..<moveToIndex]
        )
    }
}

#Preview {
    FavoritesViewBuilderMock().build()
}
