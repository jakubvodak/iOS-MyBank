//
//  TransferTableViewCell.swift
//  MyBank
//
//  Created by Jakub Vodak on 18.07.2021.
//

import UIKit

class TransferTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    static let cellIdentifier = "TransferTableViewCell"
    
    // MARK: - Outlets
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var lblAccount: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    
    // MARK: - Object Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        bgView.layer.cornerRadius = 5
    }
    
    func configureWithTransfer(transfer: Transfer) {

        guard let receiver = transfer.receiver,
              let amount = transfer.amount,
              let currency = transfer.sender?.currency else { return }
        
        lblAccount.text = "\(String(describing: receiver))"
        lblAmount.text = "-\(String(describing: amount)) \(String(describing: currency))"
        
    }
}
