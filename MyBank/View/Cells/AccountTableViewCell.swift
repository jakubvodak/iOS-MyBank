//
//  AccountTableViewCell.swift
//  MyBank
//
//  Created by Jakub Vodak on 16.07.2021.
//

import UIKit

class AccountTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    static let cellIdentifier = "AccountTableViewCell"
    
    // MARK: - Outlets
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
    @IBOutlet weak var lblBalance: UILabel!
    @IBOutlet weak var lblCurrency: UILabel!
    
    // MARK: - Object Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        bgView.layer.cornerRadius = 5
    }

    override func prepareForReuse() {
        lblTitle.text = String()
    }
    
    func configureWithAccount(account: Account) {
        lblTitle.text = account.name
        lblSubtitle.text = String(account.number ?? 0)
        lblBalance.text = String(account.balance ?? 0)
        lblCurrency.text = account.currency
    }
}
