//
//  CharacterDetailView.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 5/2/25.
//  
//

import SwiftUI

struct CharacterDetailView: View {

	@ObservedObject var viewModel: CharacterDetailViewModel

    var body: some View {
        VStack(spacing: 0) {
            if let character = viewModel.character {
                GeometryReader { geometry in
                    ScrollView(showsIndicators: false) {
                        VStack {
                            AsyncImageLoader(url: character.imageURL)
                                .padding(18)
                                .frame(width: geometry.size.width,
                                       height: geometry.size.width * 1.5)
                                .background(content: {
                                    Image.cardBackground()
                                        .resizable()
                                        .cornerRadius(6)
                                        .padding(4)
                                })
                            Text(character.name)
                                .foregroundStyle(.dbYellow)
                                .font(.notoSans(.bold(16)))
                            Text(character.raceGender)
                                .foregroundStyle(.white)
                                .font(.notoSans(.medium(12)))
                                .padding(.top, 6)
                            HStack {
                                Text("Base KI:")
                                    .foregroundStyle(.white)
                                    .font(.notoSans(.medium(12)))
                                Text(character.kii)
                                    .foregroundStyle(.dbYellow)
                                    .font(.notoSans(.medium(12)))
                            }
                            HStack {
                                Text("Total KI:")
                                    .foregroundStyle(.white)
                                    .font(.notoSans(.medium(12)))
                                Text(character.maxKi)
                                    .foregroundStyle(.dbYellow)
                                    .font(.notoSans(.medium(12)))
                            }
                            Text(character.affiliation)
                                .foregroundStyle(.dbYellow)
                                .font(.notoSans(.bold(13)))
                                .padding(.bottom, 12)
                                .padding(.top, 6)
                        }
                    }
                }
            }
        }
        .background(.dbBlack)
        .onAppear {
            viewModel.fetchCharacter()
        }
    }
}

#Preview {
    CharacterDetailViewBuilderMock().build(characterId: -1)
}
