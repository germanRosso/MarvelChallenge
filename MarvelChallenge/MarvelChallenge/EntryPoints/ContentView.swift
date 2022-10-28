//
//  ContentView.swift
//  MarvelChallenge
//
//  Created by German Rosso on 20/09/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = CharactersViewModel()
    var body: some View {
        NavigationView {
            TabView {
                CharactersView(viewmodel: viewModel)
                    .tabItem {
                        Image("superhero")
                    }
                EventsView()
                    .tabItem {
                        Image("calendar")
                            .foregroundColor(.primary)
                    }
            }
//            .task {
//                await viewModel.getCharacters()
//            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
