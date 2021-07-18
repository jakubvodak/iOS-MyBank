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
    
    // MARK: - Outlets
    
        // MARK: Sender
    
    @IBOutlet weak var txtSender: UITextField!
    
    
    // MARK: - Object Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }

    private func configureView() {
     
        self.title = "Send Money"
    
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelAction))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Confirm", style: .done, target: self, action: #selector(confirmAction))
    }
    
    // MARK: - Action
    
    @objc func cancelAction() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func confirmAction() {
        
        
    }
    
    // MARK: - TableView
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
