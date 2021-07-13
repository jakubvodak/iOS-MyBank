//
//  AccountFetcher.swift
//  MyBank
//
//  Created by Jakub Vodak on 13.07.2021.
//

import Foundation
import Combine

protocol AccountFetchable {
    func myAccounts() -> AnyPublisher<AccountsResponse, AccountError>
}

class AccountFetcher {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
}
