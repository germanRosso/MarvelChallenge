//
//  EventsAPI.swift
//  MarvelChallenge
//
//  Created by German Rosso on 05/11/2022.
//

import Foundation

extension EventsViewModel {
    enum EventsAPI {
        // Builds a URL to 'get event's data method
        case getEvents(publicKey: String, limit: Int)
//        case getEvents(publicKey: String)
        
        var url: URL? {
            var component = URLComponents()
            component.scheme = "https" // static
            component.host = "gateway.marvel.com" // static
            component.path = "/v1/public/\(pathBuilder())" // dynamic
            component.queryItems = queryBuilder() // dynamic
            return component.url
        }
        
        // query builder
        private func queryBuilder() -> [URLQueryItem]? {
            switch self {
            case .getEvents(let publicKey, let limit):
                return [URLQueryItem(name: "limit", value: String(limit)),
                        URLQueryItem(name: "apikey", value: publicKey.description),
                        URLQueryItem(name: "ts", value: "1"),
                        URLQueryItem(name: "hash", value: "51a3ecf2f92a23817992a2663183325e")
                ]
            }
        }
        
        //path builder
        private func pathBuilder() -> String {
            switch self {
            case .getEvents:
                return "events"
            }
        }
    }
    
    
    @MainActor
    func getEvents(fetchLimit: Int) async  {
        isLoading = true
        let fetchTask = Task { () -> EventsModel in
            let url = EventsAPI.getEvents(publicKey: "3a783b25c80e1c44875356dd363f272d", limit: fetchLimit).url!
            print(url)
//            let url = URL(string: "https://developer.marvel.com/docs#!/public/getCreatorCollection_get_0/v1/public/characters")!
            let (data, response) = try await URLSession.shared.data(from: url)
            let httpUrlResponse = response as? HTTPURLResponse
            var statusCode = 0
            if let statusCodeTemp = httpUrlResponse?.statusCode {
                statusCode = statusCodeTemp
            }
            
            /// Handling HTTP URL Server Response
            // ERROR scenario ❌
            if statusCode >= 400 && statusCode <= 499 {
                print("Error 400")
//                alertMessage = NetworkingError.clientError.errorDescription ?? ""
//                self.alertMessage = alertMessage
//                self.hasAnError = true
            }
            if statusCode >= 500 && statusCode <= 599 {
                print("Error 500")
//                alertMessage = NetworkingError.serverError.errorDescription ?? ""
//                self.alertMessage = alertMessage
//                self.hasAnError = true
            }
            /// OK scenario ✅
            if httpUrlResponse?.statusCode == 200 {
                print("todo está OK")
            }
            isLoading = false
            let decodedEvents = try JSONDecoder().decode(EventsModel.self, from: data)
            return decodedEvents
        }
        let result = await fetchTask.result
        
        switch result {
        case .success(let events):
            print(events.data.results.count)
            print(events.data.results.first)
            self.marvelEvents = events.data.results
        case .failure(let error):
            print("Error", error.localizedDescription)
            print(error)
//            self.alertMessage = error.localizedDescription
//            self.hasAnError = true
        }
    }
}
