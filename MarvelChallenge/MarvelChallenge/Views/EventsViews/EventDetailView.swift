//
//  EventDetailView.swift
//  MarvelChallenge
//
//  Created by German Rosso on 06/11/2022.
//

import SwiftUI

struct EventDetailView: View {
    @ObservedObject var eventsVM: EventsViewModel
    var body: some View {
        ScrollView {
            header
                .padding(.vertical)
            comics
        }
    }
    private var header: some View {
        HStack {
            AsyncImage(
                url: URL(string: eventsVM.selectedEvent.thumbnail.path+"."+eventsVM.selectedEvent.thumbnail.thumbnailExtension),
                content: { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 86, maxHeight: 86)
                        .cornerRadius(4)
                },
                placeholder: {
                    ProgressView()
                        .frame(maxWidth: 86, maxHeight: 86)
                        .background(Color.gray.opacity(0.1))
                }
            )
            .padding(.leading)
            VStack(alignment: .leading) {
                Text(eventsVM.selectedEvent.title)
                    .font(.robotoCondensed24)
                Spacer()
                Text(dateFormat(date: eventsVM.selectedEvent.start ?? ""))
                    .font(.roboto14)
                Spacer(minLength: 30)
            }
            .foregroundColor(.marvel000000)
            .padding()
            Spacer()
        }
        .frame(height: 120)
    }
    
    private var comics: some View {
        VStack {
            Text("COMICS TO DISCUSS")
                .font(.robotoCondensed20)
                .foregroundColor(.marvel222053)
                .padding(.top)
            if !eventsVM.selectedEvent.comics.items.isEmpty {
                ForEach(eventsVM.selectedEvent.comics.items, id: \.name) { comic in
                    VStack(alignment: .leading) {
                        Text(comic.name)
                            .font(.roboto16)
                            .foregroundColor(.marvel222053)
                            .padding(.vertical)
                        Divider()
                    }
                    .frame(height: 88)
                    .padding([.horizontal])
                }
            } else {
                Text("Nothing to show here!")
                    .font(.roboto14)
                    .foregroundColor(.marvel222053.opacity(0.5))
                    .padding(.top)
            }
        }
    }
}

struct EventDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EventDetailView(eventsVM: EventsViewModel())
    }
}
