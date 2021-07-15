//
//  AccountViewModel.swift
//  MyBank
//
//  Created by Jakub Vodak on 13.07.2021.
//

import Foundation
import Combine

class AccountViewModel: ObservableObject {

    private let accountFetcher: AccountFetcher
    @Published var accounts: [Account]?
    
    init(accountFetcher: AccountFetcher, scheduler: DispatchQueue = DispatchQueue(label: "AccountViewModel")) {
        self.accountFetcher = accountFetcher
        
        fetchAccounts()
    }
    
    func fetchAccounts() {
        
        accountFetcher.fetchAccounts(completionHandler: { [weak self] response, error in
            self?.accounts = response?.accounts
        })
    }
}
