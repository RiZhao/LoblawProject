//
//  LPImageRequest.swift
//  LoblawsProject
//
//  Created by Bill Zhao on 2021-02-07.
//

import Foundation
import UIKit

class LPImageRequest {
    var url: URL!
    
    init() {}
    
    init(url: URL) {
        self.url = url
    }
}

extension LPImageRequest: LPNetworkRequest {
    func decode(data: Data) -> UIImage? {
        return UIImage(data: data)
    }
    
    func makeRequest(fileUrl: URL?, successHandler: @escaping (UIImage?) -> Void, failureHandler: ((LPError) -> Void)?) {
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in

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

            if let tempURL = fileUrl {
                do {
                    try data.write(to: tempURL, options: .atomicWrite)
                } catch {
                    failureHandler?(LPError.fileWriteError)
                }

                guard let decodedData = self.decode(data: data) else {
                    failureHandler?(LPError.decodeError)
                    return
                }
                
                successHandler(decodedData)
            }
        })
        task.resume()
    }
    
    func checkCachedImagesAndLoadIfRequired(successHandler: @escaping (UIImage?) -> Void, failureHandler: ((Error) -> Void)?){
        let cachedFile = FileManager.default.temporaryDirectory
            .appendingPathComponent(
                url.relativeString,
                isDirectory: false
            )
        
        if let image = UIImage(contentsOfFile: cachedFile.path) {
            successHandler(image)
            return
        }
        
        makeRequest(fileUrl: cachedFile) { (image) in
            successHandler(image)
        } failureHandler: { (error) in
            failureHandler?(error)
        }
    }
    
}
