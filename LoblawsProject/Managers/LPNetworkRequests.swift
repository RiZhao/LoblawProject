//
//  LPNetworkRequests.swift
//  LoblawsProject
//
//  Created by Bill Zhao on 2021-02-07.
//

import UIKit

protocol LPNetworkRequest: AnyObject {

    associatedtype DataModelType
    
    func decode(data: Data) -> DataModelType?
    func makeRequest(successHandler: @escaping(DataModelType?) -> Void, failureHandler: ((LPError) -> Void)?)
}

extension LPNetworkRequest{
    
    //empty to make the call optional
    func makeRequest(successHandler: @escaping(DataModelType?) -> Void, failureHandler: ((LPError) -> Void)?) {
        
    }
}
