//
//  LPImageLoader.swift
//  LoblawsProject
//
//  Created by Bill Zhao on 2021-02-07.
//

import UIKit

class LPImageViewLoader {
    static let shared = LPImageViewLoader()
    private let imageRequest = LPImageRequest()
    
    func loadImage(url: URL, imageView: UIImageView, failureHandler: @escaping() -> Void){
        self.imageRequest.url = url
        self.imageRequest.checkCachedImagesAndLoadIfRequired { (image) in
            if let image = image {
                DispatchQueue.main.async {
                    imageView.image = image
                }
            }
        } failureHandler: { (error) in
            failureHandler()
        }

    }

}
