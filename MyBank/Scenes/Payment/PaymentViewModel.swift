//
//  PaymentViewModel.swift
//  MyBank
//
//  Created by Jakub Vodak on 17.07.2021.
//

import Foundation

class PaymentViewModel: ObservableObject {
    
    // MARK: - Variables
    
    @Published var accounts: [Account]?
    
    // MARK: - Object Lifecycle
    
    init(accounts: [Account], scheduler: DispatchQueue = DispatchQueue(label: "PamynetViewModel")) {
        self.accounts = accounts
    }
}
