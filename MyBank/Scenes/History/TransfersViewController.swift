//
//  TransfersViewController.swift
//  MyBank
//
//  Created by Jakub Vodak on 18.07.2021.
//

import UIKit

enum TransfersViewControllerTransition {
    case presented
    case pushed
}

class TransfersViewController: UIViewController {

    // MARK: - Variables
    
    var viewModel: TransfersViewModel!
    var transition: TransfersViewControllerTransition!
    
    // MARK: - Object Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }
    
    private func configureView() {
     
        if transition == .pushed {
            guard let account = viewModel.account,
                  let name = account.name else { return }
            
            self.title = "History: \(String(describing: name))"
        }
        else {
            self.title = "History"
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(closeAction))
        }
    }
    
    // MARK: - Action
    
    @objc func closeAction() {
        dismiss(animated: true, completion: nil)
    }
}
