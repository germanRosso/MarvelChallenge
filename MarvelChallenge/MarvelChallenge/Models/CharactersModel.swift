//
//  CharactersModel.swift
//  MarvelChallenge
//
//  Created by German Rosso on 23/09/2022.
//

import Foundation

struct CharactersModel: Codable {
    let code: Int
    let status: String
    let data: MarvelData
}

extension CharactersModel {
    struct MarvelData: Codable {
        let count: Int
        let results: [MarvelResults]
    }
    
    struct MarvelResults: Codable {
        let id: Int
        let name: String
        let description: String
        let thumbnail: Thumbnail
        
        static let dummyCharacter = MarvelResults(id: 1009652, name: "Thanos", description: "The Mad Titan Thanos, a melancholy, brooding individual, consumed with the concept of death, sought out personal power and increased strength, endowing himself with cybernetic implants until he became more powerful than any of his brethren.", thumbnail: CharactersModel.Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/6/40/5274137e3e2cd", url: "jpg"))
    }
    
    struct Thumbnail: Codable {
        let path: String
        let url: String
        
        enum CodingKeys: String, CodingKey {
            case path
            case url = "extension"
        }
    }
    
    struct Comics: Codable, Identifiable {
        var id = UUID()
        let available: Int
        let items: [Items]
    }
    
    struct Items: Codable {
        let resourceURI: String
        let name: String
    }
}
/*
 {
   "code": "int",
   "status": "string",
   "copyright": "string",
   "attributionText": "string",
   "attributionHTML": "string",
   "data": {
     "offset": "int",
     "limit": "int",
     "total": "int",
     "count": "int",
     "results": [
       {
         "id": "int",
         "name": "string",
         "description": "string",
         "modified": "Date",
         "resourceURI": "string",
         "urls": [
           {
             "type": "string",
             "url": "string"
           }
         ],
         "thumbnail": {
           "path": "string",
           "extension": "string"
         },
         "comics": {
           "available": "int",
           "returned": "int",
           "collectionURI": "string",
           "items": [
             {
               "resourceURI": "string",
               "name": "string"
             }
           ]
         },
         "stories": {
           "available": "int",
           "returned": "int",
           "collectionURI": "string",
           "items": [
             {
               "resourceURI": "string",
               "name": "string",
               "type": "string"
             }
           ]
         },
         "events": {
           "available": "int",
           "returned": "int",
           "collectionURI": "string",
           "items": [
             {
               "resourceURI": "string",
               "name": "string"
             }
           ]
         },
         "series": {
           "available": "int",
           "returned": "int",
           "collectionURI": "string",
           "items": [
             {
               "resourceURI": "string",
               "name": "string"
             }
           ]
         }
       }
     ]
   },
   "etag": "string"
 }
 */
