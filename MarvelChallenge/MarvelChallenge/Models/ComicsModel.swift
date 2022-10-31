//
//  ComicsModel.swift
//  MarvelChallenge
//
//  Created by German Rosso on 30/10/2022.
//

import Foundation
// MARK: - Comics
struct ComicsModel: Codable {
    let code: Int
    let status, copyright: String?
    let data: ComicsData?
}

extension ComicsModel {
    // MARK: - DataClass
    struct ComicsData: Codable {
        let results: [ComicsResults]?
    }
    
    // MARK: - Result
    struct ComicsResults: Codable {
        let id: Int
        let title: String?
        let dates: [DateElement]?
    }
    
    // MARK: - DateElement
    struct DateElement: Codable {
        let type, date: String?
    }
}
