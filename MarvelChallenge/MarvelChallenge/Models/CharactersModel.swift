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
//        let comics: Comics
    }
    
    struct Thumbnail: Codable {
        let path: String
        let url: String
        
        enum CodingKeys: String, CodingKey {
            case path
            case url = "extension"
        }
    }
    
    struct Comics: Codable {
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
