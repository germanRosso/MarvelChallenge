//
//  EventsCardView.swift
//  MarvelChallenge
//
//  Created by German Rosso on 05/11/2022.
//

import SwiftUI

struct EventsCardView: View {
    let event: EventsModel.EventsResult
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .foregroundColor(.marvelFFFFFF)
                .shadow(color: .black.opacity(0.3), radius: 2)
            HStack {
                AsyncImage(
                    url: URL(string: event.thumbnail.path+"."+event.thumbnail.thumbnailExtension),
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
                    Text(event.title)
                        .font(.robotoCondensed24)
                    Spacer()
                    Text(dateFormat(date: event.start ?? ""))
                        .font(.roboto14)
                    Spacer(minLength: 30)
                }
                .foregroundColor(.marvel000000)
                .padding()
                Spacer()
            }
            .frame(height: 120)
        }
    }
}


func dateFormat(date: String) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    guard let fetchedDate = formatter.date(from: date) else { return "No available date" }
    formatter.dateStyle = .long
    return formatter.string(from: fetchedDate)
}


struct EventsCardView_Previews: PreviewProvider {
    static var previews: some View {
        EventsCardView(event: EventsModel.EventsResult(id: 1, title: "ASHg wefjk klm", description: "", start: "", end: "", thumbnail: EventsModel.EventThumbnail(path: "", thumbnailExtension: ""), comics: EventsModel.Comics(items: [])))
    }
}
