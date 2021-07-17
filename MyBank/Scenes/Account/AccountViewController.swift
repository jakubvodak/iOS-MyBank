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
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var btnTransfers: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Object Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bindViewModel()
        configureView()
    }
    
    private func configureView() {
     
        self.title = "Wallet"
        
        btnSend.layer.cornerRadius = 10
        btnTransfers.layer.cornerRadius = 10
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }

    private func reloadView() {
        
        tableView.reloadData()
        tableView.isHidden = viewModel.dataState != .dataReady
        emptyView.isHidden = viewModel.dataState != .dataFail
        btnSend.isEnabled = viewModel.dataState == .dataReady
        btnTransfers.isEnabled = viewModel.dataState == .dataReady
        activityIndicator.isHidden = viewModel.dataState != .dataLoading
    }
    
    // MARK: - Data Binding
    
    private func bindViewModel() {
        guard let viewModel = viewModel else {return}
        viewModel.$accounts
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }.store(in: &cancellables)
        
        viewModel.$dataState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.reloadView()
            }.store(in: &cancellables)
    }
    
    // MARK: - Action
    
    @IBAction func reloadData() {
        viewModel.fetchAccounts()
    }
    
    @IBAction func sendMoney() {
        
        guard let accounts = viewModel.accounts else { return }
        let paymentViewModel = PaymentViewModel(accounts: accounts)
        
        let storyboard = UIStoryboard(name: "PaymentViewController", bundle: nil)
        let paymentViewController = storyboard.instantiateInitialViewController() as! PaymentViewController
        paymentViewController.viewModel = paymentViewModel
        
        let navigationController = UINavigationController(rootViewController: paymentViewController)
        present(navigationController, animated: true, completion: nil)
    }
    
    @IBAction func transferHistory() {
        
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
