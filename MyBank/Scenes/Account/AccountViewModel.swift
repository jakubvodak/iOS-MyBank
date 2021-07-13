//
//  AccountViewModel.swift
//  MyBank
//
//  Created by Jakub Vodak on 13.07.2021.
//

import SwiftUI
import Combine

class AccountViewModel: ObservableObject {

    private let accountFetcher: AccountFetcher
    
    init(accountFetcher: AccountFetcher, scheduler: DispatchQueue = DispatchQueue(label: "AccountViewModel")) {
        self.accountFetcher = accountFetcher
        
    }
}
