//
//  CharactersAPI.swift
//  MarvelChallenge
//
//  Created by German Rosso on 23/09/2022.
//

import Foundation
//import CryptoKit

extension CharactersViewModel {
    enum CharactersAPI {
        // Builds a URL to 'get characters's data method
        case getCharacters(publicKey: String, limit: Int)
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
            case .getCharacters(let publicKey, let limit):
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
            case .getCharacters:
                return "characters"
            }
        }
    }
    
    
    @MainActor
    func getCharacters(fetchLimit: Int) async  {
        isLoading = true
        let fetchTask = Task { () -> CharactersModel in
            let url = CharactersAPI.getCharacters(publicKey: "3a783b25c80e1c44875356dd363f272d", limit: fetchLimit).url!
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
            let decodedCharacters = try JSONDecoder().decode(CharactersModel.self, from: data)
            return decodedCharacters
        }
        let result = await fetchTask.result
        
        switch result {
        case .success(let characters):
            print(characters.data.results.count)
            self.marvelCharacters = characters.data.results
        case .failure(let error):
            print("Error", error.localizedDescription)
            print(error)
//            self.alertMessage = error.localizedDescription
//            self.hasAnError = true
        }
    }
}
