//
//  LPCartItemTableViewCell.swift
//  LoblawsProject
//
//  Created by Bill Zhao on 2021-02-07.
//

import UIKit

class LPCartItemTableViewCell: UITableViewCell {

    private let itemContentViewCornerRadius : CGFloat = 10
    private let itemContentViewShadowOffsetWidth : CGFloat = 0
    private let itemContentViewShadowOffsetHeight : CGFloat = 1
    private let itemContentViewShadowOpacity : Float = 0.3
    private let itemContentViewShadowRadius : CGFloat = 1.0
    
    private let priceLabelEachString = " ea"
    
    @IBOutlet weak var cartItemContentView: UIView!{
        didSet{
            cartItemContentView.layer.cornerRadius = itemContentViewCornerRadius
            cartItemContentView.layer.shadowColor = UIColor.black.cgColor
            cartItemContentView.layer.shadowOffset = CGSize(width: itemContentViewShadowOffsetWidth, height: itemContentViewShadowOffsetHeight)
            cartItemContentView.layer.shadowOpacity = itemContentViewShadowOpacity
            cartItemContentView.layer.shadowRadius = itemContentViewShadowRadius
        }
    }
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    
    var dataSource: LPCartItem?{
        didSet{
            guard let data = dataSource else { return }
            self.itemImageView.loadImage(url: data.image)
            self.itemNameLabel.text = data.name
            self.itemPriceLabel.text = data.price + priceLabelEachString
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
