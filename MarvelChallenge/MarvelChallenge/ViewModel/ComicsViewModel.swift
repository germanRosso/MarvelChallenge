//
//  ComicsViewModel.swift
//  MarvelChallenge
//
//  Created by German Rosso on 30/10/2022.
//

import Foundation

class ComicsViewModel: ObservableObject {
    @Published var comicsByCharacter = [ComicsModel.ComicsResults]()
    @Published var isLoading = false
}
