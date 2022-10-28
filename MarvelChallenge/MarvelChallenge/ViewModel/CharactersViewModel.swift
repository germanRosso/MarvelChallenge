//
//  CharactersViewModel.swift
//  MarvelChallenge
//
//  Created by German Rosso on 23/09/2022.
//

import Foundation

class CharactersViewModel: ObservableObject {
    @Published var charactersResponse = [CharactersModel]()
    @Published var marvelCharacters = [CharactersModel.MarvelResults]()
    @Published var isLoading = false
    // error scenario
    @Published var hasAnError = false
    @Published var alertMessage = ""
}
