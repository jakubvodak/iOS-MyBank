//
//  PaymentViewModel.swift
//  MyBank
//
//  Created by Jakub Vodak on 17.07.2021.
//

import Foundation

enum PaymentError {
    case wrongReceiverAccount
    case wrongAmount
    case insuficientAmount
    
    var errorMessage: String {
        get {
            switch self {
            case .wrongReceiverAccount:
                return "Please specify receiver account number"
            case .wrongAmount:
                return "Please specify amount to be send"
            case .insuficientAmount:
                return "You don't have enough money"
            }
        }
    }
}

class PaymentViewModel: ObservableObject {
    
    // MARK: - Variables
    
    @Published var accounts: [Account]?
    @Published var transfer: Transfer = Transfer()
    
    // MARK: - Object Lifecycle
    
    init(accounts: [Account], scheduler: DispatchQueue = DispatchQueue(label: "PamynetViewModel")) {
        self.accounts = accounts
        transfer.sender = accounts.first
    }
    
    // MARK: - Validation
    
    func transferFormError() -> PaymentError? {
        
        guard let _ = transfer.receiver else { return .wrongReceiverAccount }
        guard let amount = transfer.amount, amount > 0 else { return .wrongAmount }
        guard let amount = transfer.amount,
              let balance = transfer.sender?.balance,
              amount < balance else { return .insuficientAmount }
            
        return nil
    }
}
