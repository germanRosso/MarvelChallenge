//
//  EventsViewModel.swift
//  MarvelChallenge
//
//  Created by German Rosso on 05/11/2022.
//

import Foundation

class EventsViewModel: ObservableObject {
    @Published var marvelEvents = [EventsModel.EventsResult]()
    @Published var isLoading = false
    // error scenario
    @Published var hasAnError = false
    @Published var alertMessage = ""
    
    @Published var fetchLimit = 15
    @Published var selectedEvent: EventsModel.EventsResult
    
    init() {
        self.selectedEvent = EventsModel.EventsResult.init(id: 1, title: "", description: "", start: "", end: "", thumbnail: EventsModel.EventThumbnail(path: "", thumbnailExtension: ""), comics: EventsModel.Comics(items: []))
    }
}
