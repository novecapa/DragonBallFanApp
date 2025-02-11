//
//  SwiftDataContainer.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 5/2/25.
//

import Foundation
import SwiftData

final class SwiftDataContainer: SwiftDataContainerProtocol {

    // MARK: - Public Property
    let container: ModelContainer

    // MARK: - Initializer
    init(isStoredInMemoryOnly: Bool) {
        do {
            self.container = try ModelContainer(
                for: SDCharacter.self,
                SDCharacterFav.self,
                SDOriginPlanet.self,
                SDTransformation.self,
                configurations: ModelConfiguration(isStoredInMemoryOnly: isStoredInMemoryOnly)
            )
        } catch {
            fatalError("Failed to create model container: \(error.localizedDescription)")
        }
    }
}
