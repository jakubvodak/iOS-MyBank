//
//  AccountViewController.swift
//  MyBank
//
//  Created by Jakub Vodak on 15.07.2021.
//

import UIKit
import Combine

class AccountViewController: UIViewController {

    // MARK: - Variables
    
    var viewModel: AccountViewModel!
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Outlets
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var btnTransfers: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Object Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bindViewModel()
        configureView()
    }
    
    private func configureView() {
     
        //headerView.layer.cornerRadius = 10
        btnSend.layer.cornerRadius = 10
        btnTransfers.layer.cornerRadius = 10
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }

    // MARK: - Data Binding
    
    private func bindViewModel() {
        guard let viewModel = viewModel else {return}
        viewModel.$accounts.sink { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }.store(in: &cancellables)
    }
}

extension AccountViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.accounts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountTableViewCell.cellIdentifier, for: indexPath) as! AccountTableViewCell
        let account = viewModel.accounts![indexPath.row]
        
        cell.configureWithAccount(account: account)
        
        return cell
    }
}
