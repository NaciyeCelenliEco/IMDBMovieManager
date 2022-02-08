//
//  Request.swift
//  MovieManager
//
//  Created by Naciye Celenli on 7.02.2022.
//

import ObjectMapper

class TokenRequest: NSObject, Mappable {
    var apiKey: String = ""
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        apiKey <- map[Service.Params.apiKey.rawValue]
    }
    
}

class LoginRequest: NSObject, Mappable {
    var username: String = ""
    var password: String = ""
    var requestToken: String = ""
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        username <- map[Service.Params.username.rawValue]
        password <- map[Service.Params.password.rawValue]
        requestToken <- map[Service.Params.requestToken.rawValue]
        
    }
    
}

class SessionRequest: NSObject, Mappable {
    var requestToken: String = ""
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        requestToken <- map[Service.Params.requestToken.rawValue]
        
    }
    
}

class SearchRequest: NSObject, Mappable {
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
    }
    
}

class AccountRequest:NSObject, Mappable {
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
    }
}

class RequestObj:NSObject, Mappable {
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
    }
}

class FavRequest: NSObject, Mappable {
    var mediaType: String = ""
    var mediaID: Int = 0
    var favorite: Bool = true
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        mediaType <- map[Service.Params.mediaType.rawValue]
        mediaID <- map[Service.Params.mediaID.rawValue]
        favorite <- map[Service.Params.favorite.rawValue]
    }
}

class WatchlistRequest: NSObject, Mappable {
    var mediaType: String = ""
    var mediaID: Int = 0
    var watchlist: Bool = true
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        mediaType <- map[Service.Params.mediaType.rawValue]
        mediaID <- map[Service.Params.mediaID.rawValue]
        watchlist <- map[Service.Params.watchlist.rawValue]
    }
}
