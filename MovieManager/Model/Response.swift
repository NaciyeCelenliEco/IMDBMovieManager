//
//  Response.swift
//  MovieManager
//
//  Created by Naciye Celenli on 7.02.2022.
//

import ObjectMapper

class Token: Mappable {
    var success: Bool = false
    var expiresAt: String = ""
    var requestToken: String = ""
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        
        success <- map["success"]
        expiresAt <- map["expires_at"]
        requestToken <- map["request_token"]
        
    }
}

class Login: Mappable {
    var success: Bool = false
    var expiresAt: String = ""
    var requestToken: String = ""
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        
        success <- map["success"]
        expiresAt <- map["expires_at"]
        requestToken <- map["request_token"]
        
    }
}

class CreateSession: Mappable {
    var success: Bool = false
    var sessionId: String = ""
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        
        success <- map["success"]
        sessionId <- map["session_id"]
        
    }
}

class Search: Mappable {
    var page : Int = 0
    var results: [SearchResult] = []
    var totalPages: Int = 0
    var totalResults: Int = 0
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        
        page <- map["page"]
        results <- map["results"]
        totalPages <- map["total_pages"]
        totalResults <- map["total_results"]
        
    }
    
    class SearchResult: Mappable {
        var id : Int = 0
        var title : String = ""
        
        required init?(map: Map){
            
        }
        func mapping(map: Map) {
            
            id <- map["id"]
            title <- map["title"]
            
        }
    }
}

class Account: Mappable {
    var id: Int = 0
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        
        id <- map["id"]
        
    }
}

class MovieDetail: Mappable {
    var title: String = ""
    var originalTitle: String = ""
    var overview: String = ""
    var releaseDate: String = ""
    var voteAverage: Float = 0
    var backdropPath: String = ""
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        title <- map["title"]
        originalTitle <- map["original_title"]
        overview <- map["overview"]
        releaseDate <- map["release_date"]
        voteAverage <- map["vote_average"]
        backdropPath <- map["backdrop_path"]
    }
}

class AddWatchlist: Mappable {
    var statusCode: Int = 0
    var statusMessage: String = ""
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        
        statusCode <- map["status_code"]
        statusMessage <- map["status_message"]
        
    }
}

class AddFavorite: Mappable {
    var statusCode: Int = 0
    var statusMessage: String = ""
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        
        statusCode <- map["status_code"]
        statusMessage <- map["status_message"]
        
    }
}

class Watchlist: Mappable {
    var results: [MovieListResult] = []
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        
        results <- map["results"]
        
    }
}

class MovieListResult: Mappable {
    var id : Int = 0
    var originalTitle : String = ""
    var posterPath: String = ""
    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        
        id <- map["id"]
        originalTitle <- map["original_title"]
        posterPath <- map["poster_path"]
    }
}

class Favorites: Mappable {
    var results: [MovieListResult] = []
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        
        results <- map["results"]
        
    }
    
}

