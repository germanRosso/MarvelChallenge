//
//  EventsModel.swift
//  MarvelChallenge
//
//  Created by German Rosso on 05/11/2022.
//

import Foundation

// MARK: - EventsModel
struct EventsModel: Codable {
    let code: Int
    let status, copyright: String
    let data: EventsData
}

extension EventsModel {
    // MARK: - EventsData
    struct EventsData: Codable {
        let count: Int
        let results: [EventsResult]
    }
    
    // MARK: - EventsResult
    struct EventsResult: Codable {
        let id: Int
        let title, description: String
        let start, end: String?
        let thumbnail: EventThumbnail
        let comics: Comics
    }
    
    // MARK: - EventThumbnail
    struct EventThumbnail: Codable {
        let path, thumbnailExtension: String
        
        enum CodingKeys: String, CodingKey {
            case path
            case thumbnailExtension = "extension"
        }
    }
    
    // MARK: - Comics
    struct Comics: Codable {
        let items: [Items]
    }
    
    // MARK: - Items
    struct Items: Codable {
        let name: String
    }
}
