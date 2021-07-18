//
//  TransfersViewModel.swift
//  MyBank
//
//  Created by Jakub Vodak on 18.07.2021.
//

import Foundation
import Combine

class TransfersViewModel: ObservableObject {
    
    // MARK: - Variables
    
    var account: Account?
    var transfers: [Transfer]?
    
    var filteredTransfers: [Transfer] {
        get {
            guard let transfers = transfers else { return [] }
            guard let account = account else { return transfers }
            
            return transfers.filter {
                $0.sender?.number == account.number
            }
        }
    }
    
    
    // MARK: - Object Lifecycle
    
    init(account: Account?, transfers: [Transfer], scheduler: DispatchQueue = DispatchQueue(label: "TransfersViewModel")) {
        self.account = account
        self.transfers = transfers
    }
    
    
}
