//
//  MarvelChallengeApp.swift
//  MarvelChallenge
//
//  Created by German Rosso on 20/09/2022.
//

import SwiftUI

@main
struct MarvelChallengeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.locale, Locale(identifier: "es"))
        }
    }
}
