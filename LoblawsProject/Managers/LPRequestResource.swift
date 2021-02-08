//
//  LPRequestResource.swift
//  LoblawsProject
//
//  Created by Bill Zhao on 2021-02-07.
//

import UIKit

protocol LPRequestResource {
    associatedtype DataModelType: Decodable
    
    var scheme: String {
        get
    }

    var baseURL: String {
        get
    }
    
    var path: String {
        get
    }
    
    var parameters: [URLQueryItem]? {
        get
    }
    
    var method: String {
        get
    }
}
