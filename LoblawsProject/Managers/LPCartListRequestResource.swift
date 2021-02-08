//
//  LPCartListRequestResource.swift
//  LoblawsProject
//
//  Created by Bill Zhao on 2021-02-07.
//
import UIKit

enum LPCartListRequestResource: LPRequestResource{
    
    case getCartItems
    
    typealias DataModelType = LPCart
    
    var scheme: String {
        switch self {
        default:
            return "https"
        }
    }
    
    var baseURL: String {
        switch self {
        default:
            return "gist.githubusercontent.com"
        }
    }
    
    var path: String {
        switch self {
        default: return  "/r2vq/2ac197145db3f6cdf1a353feb744cf8e/raw/b1e722f608b00ddde138a0eef2261c6ffc8b08d7/cart.json"
        }
    }
    
    var parameters: [URLQueryItem]? {
        switch self{
        default:
            return nil
        }
    }
    
    var method: String {
        switch self{
        default:
            return "GET"
        }
    }
}
