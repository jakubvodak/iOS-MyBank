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
    
    var viewModel: AccountViewModel?
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Outlets
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var btnTransfers: UIButton!
    
    // MARK: - Object Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bindViewModel()
        configureView()
    }
    
    private func configureView() {
     
        headerView.layer.cornerRadius = 10
        btnSend.layer.cornerRadius = 10
        btnTransfers.layer.cornerRadius = 10
    }

    private func bindViewModel() {
        guard let viewModel = viewModel else {return}
        viewModel.$accounts.sink { _ in
            
        }.store(in: &cancellables)
    }
}
