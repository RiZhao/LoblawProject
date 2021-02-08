//
//  LPCartModel.swift
//  LoblawsProject
//
//  Created by Bill Zhao on 2021-02-07.
//

import Foundation

struct LPCart: Decodable{
    let entries: [LPCartItem]
}

struct LPCartItem: Decodable{
    let code: String
    let image: String
    let name: String
    let price: String
    let type: ItemType
    
    enum ItemType: String, Decodable, CaseIterable{
        case beautyFace = "BeautyFace"
        case shampoo = "Shampoo"
        case accessories = "Accessories"
        case hairColour = "HairColour"
    }
}
