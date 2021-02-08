//
//  LPCartListTableViewController.swift
//  LoblawsProject
//
//  Created by Bill Zhao on 2021-02-07.
//

import UIKit

protocol LPCartItemSelectionDelegate: class {
    func itemSelected(_ item: LPCartItem)
}

class LPCartListTableViewController: UITableViewController {

    private let cartItemCellReuseId = "cartItemCell"
    private let cartItemCellNibName = "LPCartItemTableViewCell"
    private let viewTitle = "Your Cart"
    private let filterButtonTitle = "Filter"
    private let filtersClearFilterTitle = "Clear Filters"
    private let tableViewHeightRatioOfScreen : CGFloat = 0.2
    private let indicatorView = LPActivityIndicatorViewController()
    private var request: AnyObject?
    
    weak var delegate: LPCartItemSelectionDelegate?
    
    private var cartItems = [LPCartItem](){
        didSet{
            tableView.reloadData()
        }
    }
    
    private var backUpCartItems = [LPCartItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = viewTitle
        configureTableView()
        initializeData()
        configureNavigationBarButtons()
    }
    
    private func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: cartItemCellNibName, bundle: nil), forCellReuseIdentifier: cartItemCellReuseId)
    }
}

// MARK: - Initialize Data Functions
extension LPCartListTableViewController{
    
    private func initializeData(){
        presentLoadingIndicator()
        let request = LPApiRequest(resource: LPCartListRequestResource.getCartItems)
        self.request = request
        request.makeRequest {[weak self] (data) in
            self?.dismissLoadingIndicator()
            guard let data = data else { return }
            self?.setSuccessfulTableViewData(data: data.entries)
        } failureHandler: {[weak self] (error) in
            self?.dismissLoadingIndicator()
            self?.setFailureTableView(error: error)
        }
    }
    
    private func presentLoadingIndicator(){
        present(indicatorView, animated: true, completion: nil)
    }
    
    private func dismissLoadingIndicator(){
        indicatorView.dismiss(animated: true, completion: nil)
    }
    
    private func setSuccessfulTableViewData(data: [LPCartItem]){
        self.cartItems = data
        self.backUpCartItems = data
    }
    
    private func setFailureTableView(error: LPError){
        self.cartItems = [LPCartItem]()
        self.tableView.setEmptyMessage(error.rawValue)
    }
}

// MARK: - Table view functions
extension LPCartListTableViewController{

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cartItemCellReuseId, for: indexPath) as! LPCartItemTableViewCell
        cell.dataSource = cartItems[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegueWith(index: indexPath.row)
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.size.height * self.tableViewHeightRatioOfScreen
    }
    
}

// MARK: - Segue Functions
extension LPCartListTableViewController{
    
    private func performSegueWith(index: Int){
        let item = self.cartItems[index]
        delegate?.itemSelected(item)
        if let detailViewController = delegate as? LPCartItemDetailViewController {
          splitViewController?.showDetailViewController(detailViewController, sender: nil)
        }
    }
}

// MARK: Navigation Bar Buttons logic
extension LPCartListTableViewController {
    
    private func configureNavigationBarButtons(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: filterButtonTitle, style: .plain, target: self, action: #selector(filterTapped))
    }
    
    @objc private func filterTapped(){
        createFilterSelectionAlert()
    }
    
    private func createFilterSelectionAlert(){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        for type in LPCartItem.ItemType.allCases {
            alert.addAction(UIAlertAction(title: type.rawValue, style: .default) { _ in
                // Simple filter that updates the tableview depending on the item type
                self.cartItems = self.backUpCartItems.filter({ $0.type == type })
            })
        }
        alert.addAction(UIAlertAction(title: filtersClearFilterTitle, style: .destructive) { _ in
            // check if clear filter is needed
            if self.cartItems.count == self.backUpCartItems.count { return }
            self.cartItems = self.backUpCartItems
        })

        present(alert, animated: true)
    }

}
