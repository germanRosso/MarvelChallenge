//
//  ContentView.swift
//  MarvelChallenge
//
//  Created by German Rosso on 20/09/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 0
    init() {
        UITabBar.appearance().backgroundColor = UIColor.white
    }
    var body: some View {
        ZStack {
            NavigationView {
                TabView(selection: $selection) {
                    CharactersView()
                        .tabItem {
                            VStack {
                                Image(selection == 0 ? "superhero" : "superhero-gray")
                                Text("Characters")
                            }
                        }
                        .tag(0)
                    EventsView()
                        .tabItem {
                            VStack {
                                Image(selection == 1 ? "calendar" : "calendar-gray")
                                Text("Characters")
                            }
                        }
                        .tag(1)
                }
                .accentColor(.marvel262626)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
