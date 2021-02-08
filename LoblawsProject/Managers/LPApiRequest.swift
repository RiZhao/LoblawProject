//
//  LPApiRequest.swift
//  LoblawsProject
//
//  Created by Bill Zhao on 2021-02-07.
//

import UIKit

class LPApiRequest<Resource: LPRequestResource> {
    let resource: Resource

    init(resource: Resource){
        self.resource = resource
    }

}

extension LPApiRequest: LPNetworkRequest{
    func decode(data: Data) -> Resource.DataModelType? {
        let items = try? JSONDecoder().decode(Resource.DataModelType.self, from: data)
        return items
    }
    
    func makeRequest(successHandler: @escaping (Resource.DataModelType?) -> Void, failureHandler: ((LPError) -> Void)?) {
        var components = URLComponents()
        components.scheme = self.resource.scheme
        components.host = self.resource.baseURL
        components.path = self.resource.path
        components.queryItems = self.resource.parameters
        
        guard let url = components.url else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = self.resource.method
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
        let task = session.dataTask(with: request, completionHandler: { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            guard error == nil else {
                failureHandler?(LPError.clientError)
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                failureHandler?(LPError.serverError)
                return
            }
            
            guard let data = data else {
                failureHandler?(LPError.dataError)
                return
            }
            let resultJson = String(data: data, encoding: String.Encoding.utf8) ?? ""
            print(resultJson)
            guard let decodedData = self?.decode(data: data) else {
                failureHandler?(LPError.decodeError)
                return
            }
            
            successHandler(decodedData)
        })
        task.resume()
    }
}
