//
//  PaymentViewController.swift
//  MyBank
//
//  Created by Jakub Vodak on 17.07.2021.
//

import UIKit
import Combine

class PaymentViewController: UITableViewController {

    // MARK: - Variables
    
    var viewModel: PaymentViewModel!
    
    // MARK: - Object Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }

    private func configureView() {
     
        self.title = "Send Money"
    
    }
    
    // MARK: - TableView
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
