//
//  CharactersDetailView.swift
//  MarvelChallenge
//
//  Created by German Rosso on 30/10/2022.
//

import SwiftUI

struct CharactersDetailView: View {
    @StateObject var comicsVM = ComicsViewModel()
    @ObservedObject var charactersVM: CharactersViewModel
    @Binding var showCharacterDetails: Bool
    var body: some View {
        VStack(spacing: 0) {
            MarvelHeaderView(title: charactersVM.selectedCharacter.name, action: {withAnimation {showCharacterDetails = false}}, opacity: 100, disabled: false)
            ScrollView {
                characterImage
                characterDescription
                characterComics
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .frame(maxWidth: UIScreen.width)
        .background(Color.white)
        .task {
            await comicsVM.getComics()
        }
    }
    private var characterImage: some View {
            AsyncImage(
                url: URL(string: charactersVM.selectedCharacter.thumbnail.path+"."+charactersVM.selectedCharacter.thumbnail.url),
                content: { image in
                    image.resizable()
                        .scaledToFit()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: UIScreen.width)
                },
                placeholder: {
                    ProgressView()
                        .frame(maxWidth: UIScreen.width, minHeight: 360)
                        .background(Color.gray.opacity(0.1))
                }
            )
    }
    private var characterDescription: some View {
        VStack {
            Text(charactersVM.selectedCharacter.description)
                .font(.roboto14)
                .foregroundColor(.marvel222053)
                .frame(width: UIScreen.width80)
                .padding(.vertical)
                .multilineTextAlignment(.center)
        }
    }
    private var characterComics: some View {
        VStack {
            Text("APEARS IN THESE COMICS")
                .font(.robotoCondensed20)
                .foregroundColor(.marvel222053)
                .padding(.top)
            ForEach(comicsVM.comicsByCharacter, id: \.id) { comic in
                VStack(alignment: .leading) {
                    Text(comic.title ?? "")
                        .font(.roboto16)
                        .foregroundColor(.marvel222053)
                        .padding(.vertical)
                    Text(yearFormat(date: comic.dates?[0].date ?? ""))
                        .font(.roboto14)
                        .foregroundColor(.marvel222053.opacity(0.5))
                    Divider()
                }
                .frame(height: 88)
                .padding([.horizontal, .bottom])
            }
        }
    }
    private func yearFormat(date: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss-HHmm"
        let fetchedDate = formatter.date(from: date) ?? Date()
        formatter.dateFormat = "yyyy"
        return formatter.string(from: fetchedDate)
    }
}

struct CharactersDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersDetailView(charactersVM: CharactersViewModel(), showCharacterDetails: .constant(false))
    }
}
