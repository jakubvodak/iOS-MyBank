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
    
    // MARK: - Object Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        bgView.layer.cornerRadius = 5
    }
}
