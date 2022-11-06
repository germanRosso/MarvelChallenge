//
//  CharactersView.swift
//  MarvelChallenge
//
//  Created by German Rosso on 23/09/2022.
//

import SwiftUI

struct CharactersView: View {
    @ObservedObject var charactersVM: CharactersViewModel
    @State var showCharacterDetails = false
    var body: some View {
        ZStack {
            VStack {
                MarvelHeaderView(title: "Marvel Challenge", action: {}, opacity: 0, disabled: true)
                charactersList
            }
            .background(Color.marvelECEFF1)
            if showCharacterDetails {
                CharactersDetailView(charactersVM: charactersVM, showCharacterDetails: $showCharacterDetails)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await charactersVM.getCharacters(fetchLimit: charactersVM.fetchLimit)
        }
    }
    private var charactersList: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack {
                    ForEach(charactersVM.marvelCharacters.sorted(by: {$0.name < $1.name}), id: \.name) { character in
                        CharactersCardView(character: character)
                            .onTapGesture {
                                charactersVM.selectedCharacter = character
                                withAnimation {
                                    showCharacterDetails = true
                                }
                            }
                        if charactersVM.marvelCharacters.last?.name == character.name && charactersVM.fetchLimit <= 90 {
                            ProgressView()
                                .padding(.vertical, 5)
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        if charactersVM.fetchLimit < 90 {
                                            charactersVM.fetchLimit += 15
                                        } else {
                                            charactersVM.fetchLimit += 9
                                        }
                                        Task {
                                            await charactersVM.getCharacters(fetchLimit: charactersVM.fetchLimit)
                                        }
                                    }
                                }
                        }
                    }
                }
                .frame(width: UIScreen.width * 0.95)
                .padding(.vertical, 5)
            }
            .background(Color.marvelECEFF1)
            .onDisappear {
                charactersVM.fetchLimit = 15
                proxy.scrollTo(charactersVM.marvelCharacters[0].name, anchor: .top)
            }
        }
    }
    private var columns: [GridItem] {
        let columns = [
            GridItem(.flexible())
        ]
        return columns
    }
}

struct CharactersView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersView(charactersVM: CharactersViewModel())
    }
}
