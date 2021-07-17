//
//  PaymentViewController.swift
//  MyBank
//
//  Created by Jakub Vodak on 17.07.2021.
//

import UIKit
import Combine

class PaymentViewController: UIViewController {

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
}
