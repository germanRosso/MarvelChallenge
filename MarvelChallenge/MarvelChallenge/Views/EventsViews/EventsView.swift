//
//  EventsView.swift
//  MarvelChallenge
//
//  Created by German Rosso on 23/09/2022.
//

import SwiftUI

struct EventsView: View {
    @ObservedObject var eventsVM: EventsViewModel
    @State var showEventDetails = false
    var body: some View {
        ZStack {
            VStack {
                MarvelHeaderView(title: "Marvel Challenge", action: {}, opacity: 0, disabled: true)
                eventsList
            }
            .background(Color.marvelECEFF1)
            .sheet(isPresented: $showEventDetails) {
                EventDetailView(eventsVM: eventsVM)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await eventsVM.getEvents(fetchLimit: eventsVM.fetchLimit)
        }
    }
    private var eventsList: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack {
                    ForEach(eventsVM.marvelEvents, id: \.id) { event in
                        EventsCardView(event: event)
                            .onTapGesture {
                                eventsVM.selectedEvent = event
                                withAnimation {
                                    showEventDetails = true
                                }
                            }
                        if eventsVM.marvelEvents.last?.title == event.title && eventsVM.fetchLimit <= 90 {
                            ProgressView()
                                .padding(.vertical, 5)
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        if eventsVM.fetchLimit < 90 {
                                            eventsVM.fetchLimit += 15
                                        } else {
                                            eventsVM.fetchLimit += 9
                                        }
                                        Task {
                                            await eventsVM.getEvents(fetchLimit: eventsVM.fetchLimit)
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
                eventsVM.fetchLimit = 15
                proxy.scrollTo(eventsVM.marvelEvents[0].title, anchor: .top)
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

struct EventsView_Previews: PreviewProvider {
    static var previews: some View {
        EventsView(eventsVM: EventsViewModel())
    }
}
