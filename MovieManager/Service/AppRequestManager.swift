//
//  AppRequestManager.swift
//  MovieManager
//
//  Created by Naciye Celenli on 7.02.2022.
//

//
//  AppRequestManager.swift
//  TrueColors
//
//  Created by Ugur Cakmakci on 5.09.2019.
//  Copyright © 2019 ifloop. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class AppRequestManager: BaseRequestManager {
    
    public func get<T: Mappable>(_ endpoint: Service.Enpoints, _ obj: T.Type, _ params:[String:Any]? = nil, _ headers:HTTPHeaders? = nil, completion: @escaping (T?, Error?) -> Void) {
        _postUrl = endpoint.url
        _method = endpoint.method
        _dicParams = params;
        _dicHeader = endpoint.headers
        _encoding = endpoint.encoding;
        
        
        responseObject(obj: T.self) { (result) in
            switch result {
            case .success(let data):
                completion(data,nil)
            case .failure(let err):
                completion(nil,err)
            }
        }
    }
}


struct Service {

    static let BASE_URL                     = "https://api.themoviedb.org/3/";
    enum Enpoints {
        case token
        case login
        case createSession
        case search(query:String)
        case account(sessionId:String)
        case movieDetail(movieId:Int)
        case addWatchlist(accountId:Int, sessionId:String)
        case addFavorite(accountId:Int, sessionId:String)
        case getWatchlist(accountId:Int, sessionId:String)
        case getFavorites(accountId:Int, sessionId:String)

        public var url: String {
            return String(format: "%@%@", Service.BASE_URL,relativeURLString)

        }
        
        public var method: HTTPMethod {
            switch self {
            case .token:
                return .get
            case .login:
                return .post
            case .createSession:
                return .post
            case .search:
                return .get
            case .account:
                return .get
            case .movieDetail:
                return .get
            case .addWatchlist:
                return .post
            case .addFavorite:
                return .post
            case .getWatchlist:
                return .get
            case .getFavorites:
                return .get
            }
        }
        
        public var encoding: ParameterEncoding {
            return URLEncoding.queryString
        }
        
        public var headers: HTTPHeaders {
            let header: [HTTPHeader] = []
            return .init(header)

        }
        
        
        private var relativeURLString: String {
            
            switch self {
            case .token:
                return "authentication/token/new";
            case .login:
                return "authentication/token/validate_with_login?api_key=\(Constants.Api.Key)";
            case .createSession:
                return "authentication/session/new?api_key=\(Constants.Api.Key)";
            case .search(let query):
                return "search/movie?api_key=\(Constants.Api.Key)&query=\(query)&page=1"
            case .account(let sessionId):
                return "account?api_key=\(Constants.Api.Key)&session_id=\(sessionId)"
            case .movieDetail(let movieId):
                return "movie/\(movieId)?api_key=\(Constants.Api.Key)&language=en-US"
            case .addWatchlist(let accountId, let sessionId):
                return "account/\(accountId)/watchlist?api_key=\(Constants.Api.Key)&session_id=\(sessionId)"
            case .addFavorite(let accountId, let sessionId):
                return "account/\(accountId)/favorite?api_key=\(Constants.Api.Key)&session_id=\(sessionId)"
            case .getWatchlist(let accountId, let sessionId):
                return "account/\(accountId)/watchlist/movies?api_key=\(Constants.Api.Key)&language=en-US&session_id=\(sessionId)&sort_by=created_at.asc&page=1"
            case .getFavorites(let accountId, let sessionId):
                return "account/\(accountId)/favorite/movies?api_key=\(Constants.Api.Key)&session_id=\(sessionId)&language=en-US&sort_by=created_at.asc&page=1"
            }
        }
    };
    
    enum Params: String {
        case username
        case password
        case apiKey = "api_key"
        case requestToken = "request_token"
        case mediaType = "media_type"
        case mediaID = "media_id"
        case favorite
        case watchlist
        
    }
    
    
}
