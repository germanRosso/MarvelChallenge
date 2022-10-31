//
//  CharactersView.swift
//  MarvelChallenge
//
//  Created by German Rosso on 23/09/2022.
//

import SwiftUI

struct CharactersView: View {
    @StateObject var viewModel = CharactersViewModel()
    @State var showDetails = false
    var body: some View {
        ZStack {
            VStack {
                MarvelHeaderView(title: "Marvel Challenge", action: {}, opacity: 0, disabled: true)
                charactersList
            }
            .background(Color.marvelECEFF1)
            if showDetails {
                CharactersDetailView(viewModel: viewModel, showDetails: $showDetails)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.getCharacters(fetchLimit: viewModel.fetchLimit)
        }
    }
    private var charactersList: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.marvelCharacters.sorted(by: {$0.name < $1.name}), id: \.name) { character in
                        CharactersCardView(character: character)
                            .onTapGesture {
                                viewModel.selectedCharacter = character
                                withAnimation {
                                    showDetails = true
                                }
                            }
                        if viewModel.marvelCharacters.last?.name == character.name && viewModel.fetchLimit <= 90 {
                            ProgressView()
                                .padding(.vertical, 5)
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        if viewModel.fetchLimit < 90 {
                                            viewModel.fetchLimit += 15
                                        } else {
                                            viewModel.fetchLimit += 9
                                        }
                                        Task {
                                            await viewModel.getCharacters(fetchLimit: viewModel.fetchLimit)
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
                viewModel.fetchLimit = 15
                proxy.scrollTo(viewModel.marvelCharacters[0].name, anchor: .top)
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
        CharactersView(viewModel: CharactersViewModel())
    }
}
