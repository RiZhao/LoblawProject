//
//  LPImageViewExtensions.swift
//  LoblawsProject
//
//  Created by Bill Zhao on 2021-02-07.
//

import UIKit

extension UIImageView {
    
    func loadImage(url: String?) {
        // Set default image if download image fails
        func setDefaultPhoto(){
            self.image = .remove
        }
        
        guard let urlString = url else {
            setDefaultPhoto()
            return

        }
        
        guard let url = URL(string: urlString) else{
            setDefaultPhoto()
            return

        }
        
        LPImageViewLoader.shared.loadImage(url: url, imageView: self, failureHandler: {
            setDefaultPhoto()
            return
        })
    }
}
