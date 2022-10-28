//
//  CharactersView.swift
//  MarvelChallenge
//
//  Created by German Rosso on 23/09/2022.
//

import SwiftUI

struct CharactersView: View {
    @StateObject var viewmodel: CharactersViewModel
    var body: some View {
        VStack(spacing:0) {
            headerView
            ScrollView {
                ForEach(viewmodel.marvelCharacters.lazy.sorted(by: {$0.name < $1.name}), id: \.name) { superhero in
                    CharacterCardView(imagePath: superhero.thumbnail.path, imageFormat: superhero.thumbnail.url, title: superhero.name, subtitle: superhero.description)
                }
                .task {
                    await viewmodel.getCharacters()
                }
            }
            .frame(width: UIScreen.main.bounds.width * 0.9)
            .padding()
            .background(Color.marvelECEFF1)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    private var headerView: some View {
        ZStack {
            Color.marvel262626
                .edgesIgnoringSafeArea(.top)
            Text("Marvel Challenge")
                .foregroundColor(.marvelFFFFFF)
                .font(.robotoCondensedBold20)
        }
        .frame(height: 56)
    }
}

struct CharacterCardView: View {
    var imagePath: String
    var imageFormat: String
    var title: String
    var subtitle: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(.marvelFFFFFF)
                .shadow(color: .black.opacity(0.3), radius: 2)
            HStack {
                AsyncImage(
                    url: URL(string: imagePath+"."+imageFormat),
                    content: { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 120, maxHeight: 120)
                    },
                    placeholder: {
                        ProgressView()
                            .frame(maxWidth: 120, maxHeight: 120)
                    }
                )
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.robotoCondensed24)
                    Text(subtitle)
                        .font(.roboto14)
                }
                .padding()
                Spacer()
            }
        }
        .frame(height: 120)
        .padding(5)
    }
}

struct CharactersView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersView(viewmodel: CharactersViewModel())
    }
}
