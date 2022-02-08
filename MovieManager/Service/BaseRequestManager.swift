//
//  BaseRequestManager.swift
//  MovieManager
//
//  Created by Naciye Celenli on 7.02.2022.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class BaseRequestManager: SessionDelegate {
    
    public var _dicParams: [String:Any]? = [:]
    public var _dicHeader: HTTPHeaders? = nil
    public var _method: HTTPMethod = .get
    public var _encoding: ParameterEncoding = URLEncoding.default
    public var _imgData: Data? = nil
    public var _postUrl = "";
    
    
    
    private func log() {
        print(String(format:"--- Url %@ ---",_postUrl));
        print(String(format:"--- Params %@ ---",String(describing:_dicParams)));
        print(String(format:"--- Header %@ ---",String(describing:_dicHeader)));
        print(String(format:"--- Method %@ ---",_method.rawValue))
        
    }
    
    
    public func responseObject<T: Mappable>(obj: T.Type, completion: @escaping (Result<T, AFError>) -> Void) {
        
        log()
        AF.request(_postUrl, method: _method, parameters: _dicParams, encoding: _encoding, headers: _dicHeader).validate().responseObject { (response: DataResponse<T,AFError>) in
            completion(response.result);
        }
        
    }
    
}

