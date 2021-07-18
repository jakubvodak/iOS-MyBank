//
//  AccountViewModel.swift
//  MyBank
//
//  Created by Jakub Vodak on 13.07.2021.
//

import Foundation
import Combine

enum AccountViewModelDataState {
    case dataLoading
    case dataReady
    case dataFail
}

class AccountViewModel: ObservableObject {

    // MARK: - Variables
    
    @Published var accounts: [Account]?
    @Published var transfers: [Transfer]?
    @Published var dataState: AccountViewModelDataState = .dataFail
    
    private let accountFetcher: AccountFetcher
    
    // MARK: - Object Lifecycle
    
    init(accountFetcher: AccountFetcher, scheduler: DispatchQueue = DispatchQueue(label: "AccountViewModel")) {
        self.accountFetcher = accountFetcher
        
        fetchAccounts()
        fetchTransfers()
    }
    
    func fetchAccounts() {
        
        if dataState == .dataLoading { return }
        dataState = .dataLoading
        
        accountFetcher.fetchAccounts(completionHandler: { [weak self] response, error in
            
            if let data = response, !data.accounts.isEmpty {
                self?.accounts = data.accounts
                self?.dataState = .dataReady
            }
            else {
                self?.dataState = .dataFail
            }
        })
    }
    
    func fetchTransfers() {
        transfers = [Transfer]()
    }
    
    func appendTransfer(transfer: Transfer) {
        transfers?.append(transfer)
    }
}
