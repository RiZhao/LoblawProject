//
//  LPCartItemDetailViewController.swift
//  LoblawsProject
//
//  Created by Bill Zhao on 2021-02-07.
//

import UIKit

class LPCartItemDetailViewController: UIViewController {

    private let itemInfoContentViewCornerRadius : CGFloat = 10.0
    private let itemInfoContentViewShadowOffsetWidth : CGFloat = 0
    private let itemInfoContentViewShadowOffsetHeight : CGFloat = 1
    private let itemInfoContentViewShadowOpacity : Float = 0.3
    private let itemInfoContentViewShadowRadius : CGFloat = 1.0
    
    private let priceLabelEachString = " ea"
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemInfoContentView: UIView!{
        didSet{
            itemInfoContentView.layer.cornerRadius = itemInfoContentViewCornerRadius
            itemInfoContentView.layer.shadowColor = UIColor.black.cgColor
            itemInfoContentView.layer.shadowOffset = CGSize(width: itemInfoContentViewShadowOffsetWidth, height: itemInfoContentViewShadowOffsetHeight)
            itemInfoContentView.layer.shadowOpacity = itemInfoContentViewShadowOpacity
            itemInfoContentView.layer.shadowRadius = itemInfoContentViewShadowRadius
        }
    }
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    
    private var itemData : LPCartItem?{
        didSet{
            guard itemData != nil, itemImageView != nil else { return }
            configureUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI(){
        guard let data = itemData else { return }
        itemImageView.loadImage(url: data.image)
        itemNameLabel.text = data.name
        itemPriceLabel.text = data.price + priceLabelEachString
    }

}

extension LPCartItemDetailViewController: LPCartItemSelectionDelegate{
    func itemSelected(_ item: LPCartItem) {
        self.itemData = item
    }
}
