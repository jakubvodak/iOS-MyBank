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
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
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
        
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
    
    // MARK: - Action
    
    @objc func closeAction() {
        dismiss(animated: true, completion: nil)
    }
}

extension TransfersViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TransferTableViewCell.cellIdentifier, for: indexPath) as! TransferTableViewCell
        
        
        
        return cell
    }
    
    
    
}
