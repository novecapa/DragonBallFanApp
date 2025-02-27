//
//  FavoriteCardView.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 27/2/25.
//

import SwiftUI

struct FavoriteCardView: View {

    let character: CharacterEntity
    let proxy: GeometryProxy

    var body: some View {
        VStack(spacing: 0) {
            AsyncImageLoader(url: character.imageURL)
                .padding(18)
                .frame(width: proxy.size.width,
                       height: proxy.size.width * 1.5)
                .background(content: {
                    Image.cardBackground()
                        .resizable()
                        .cornerRadius(6)
                        .padding(4)
                })
                .cornerRadius(6)
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
        .border(.dbYellow, width: 6)
        .cornerRadius(12)
        .background(.dbBlack)
    }
}
