//
//  CharactersCardView.swift
//  MarvelChallenge
//
//  Created by German Rosso on 31/10/2022.
//

import SwiftUI

struct CharactersCardView: View {
    let character: CharactersModel.MarvelResults
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .foregroundColor(.marvelFFFFFF)
                .shadow(color: .black.opacity(0.3), radius: 2)
            HStack {
                AsyncImage(
                    url: URL(string: character.thumbnail.path+"."+character.thumbnail.url),
                    content: { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 120, maxHeight: 120)
                            .cornerRadius(4)
                    },
                    placeholder: {
                        ProgressView()
                            .frame(maxWidth: 120, maxHeight: 120)
                            .background(Color.gray.opacity(0.1))
                    }
                )
                VStack(alignment: .leading) {
                    Text(character.name)
                        .font(.robotoCondensed24)
                    Text(character.description)
                        .font(.roboto14)
                }
                .foregroundColor(.marvel000000)
                .padding()
                Spacer()
            }
            .frame(height: 120)
        }
    }
}

struct CharactersCardView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersCardView(character: CharactersModel.MarvelResults.dummyCharacter)
    }
}
