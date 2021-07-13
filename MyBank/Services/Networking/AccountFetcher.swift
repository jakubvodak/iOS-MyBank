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

extension AccountFetcher: AccountFetchable {
    
    func myAccounts() -> AnyPublisher<AccountsResponse, AccountError> {
        return fetchAccounts(with: makeAccountsRequestComponents())
    }
    
    private func fetchAccounts<T>(with components: URLComponents) -> AnyPublisher<T, AccountError> where T: Decodable {
        
        guard let url = components.url else {
            let error = AccountError.network(description: "Invalid URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        return session.dataTaskPublisher(for: URLRequest(url: url))
          .mapError { error in
            .network(description: error.localizedDescription)
          }
          .flatMap(maxPublishers: .max(1)) { pair in
            decode(pair.data)
          }
          .eraseToAnyPublisher()
    }
}

private extension AccountFetcher {
    struct BankAPI {
        static let scheme = "http"
        static let host = "kali.fio.cz"
        static let path = "/test/accounts.json"
    }
    
    func makeAccountsRequestComponents() -> URLComponents {
        var components = URLComponents()
        components.scheme = BankAPI.scheme
        components.host = BankAPI.host
        components.path = BankAPI.path
        return components
    }
}
