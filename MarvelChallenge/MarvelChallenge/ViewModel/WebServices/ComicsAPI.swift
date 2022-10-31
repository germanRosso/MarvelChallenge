//
//  ComicsAPI.swift
//  MarvelChallenge
//
//  Created by German Rosso on 30/10/2022.
//

import Foundation

extension ComicsViewModel {
    enum ComicsAPI {
        // Builds a URL to 'get comics's data method
        case getComics(publicKey: String)
        
        var url: URL? {
            var component = URLComponents()
            component.scheme = "https" // static
            component.host = "gateway.marvel.com" // static
            component.path = "/v1/public/\(pathBuilder())" // dynamic
            component.queryItems = queryBuilder(fetchLimit: CharactersViewModel().fetchLimit) // dynamic
            return component.url
        }
        
        // query builder
        private func queryBuilder(fetchLimit: Int) -> [URLQueryItem]? {
            switch self {
            case .getComics(let publicKey):
                return [URLQueryItem(name: "limit", value: String(fetchLimit)),
                        URLQueryItem(name: "apikey", value: publicKey.description),
                        URLQueryItem(name: "ts", value: "1"),
                        URLQueryItem(name: "hash", value: "51a3ecf2f92a23817992a2663183325e")
                ]
            }
        }
        
        //path builder
        private func pathBuilder() -> String {
            switch self {
            case .getComics:
                //https://gateway.marvel.com:443/v1/public/characters/1009652/comics?apikey=87acf6b899cc55864049a9c54e2d04ae
                return "characters/\(CharactersViewModel().selectedCharacter.id)/comics"
            }
        }
    }
    
    @MainActor
    func getComics() async  {
        isLoading = true
        let fetchTask = Task { () -> ComicsModel in
            let url = ComicsAPI.getComics(publicKey: "3a783b25c80e1c44875356dd363f272d").url!
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
            let decodedCharacters = try JSONDecoder().decode(ComicsModel.self, from: data)
            return decodedCharacters
        }
        let result = await fetchTask.result
        
        switch result {
        case .success(let comics):
//            print(comics.data?.results)
            self.comicsByCharacter = comics.data?.results ?? []
        case .failure(let error):
            print("Error", error.localizedDescription)
            print(error)
//            self.alertMessage = error.localizedDescription
//            self.hasAnError = true
        }
    }
}
