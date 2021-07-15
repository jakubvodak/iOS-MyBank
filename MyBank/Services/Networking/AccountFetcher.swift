//
//  AccountFetcher.swift
//  MyBank
//
//  Created by Jakub Vodak on 13.07.2021.
//

import Foundation
import Combine

protocol AccountFetchable {
    func fetchAccounts(completionHandler:@escaping (AccountsResponse?, AccountError?) -> ())
}

class AccountFetcher {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
}

extension AccountFetcher: AccountFetchable {
    func fetchAccounts(completionHandler:@escaping (AccountsResponse?, AccountError?) -> ())  {
        session.dataTask(with: makeAccountRequest()) { (data, response, error) in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let accountsResponse = try decoder.decode(AccountsResponse.self, from: data)
                    completionHandler(accountsResponse, nil)
                }
                catch {
                    completionHandler(nil, AccountError.parsing)
                }
            }
            else {
                completionHandler(nil, AccountError.network)
            }
        }.resume()
    }
}

private extension AccountFetcher {
    struct BankAPI {
        static let scheme = "http://"
        static let host = "kali.fio.cz"
        static let path = "/test/accounts.json"
    }
    
    func makeAccountsRequestURL() -> URL! {
        return URL(string: BankAPI.scheme + BankAPI.host + BankAPI.path)
    }
    
    func makeAccountRequest() -> URLRequest {
        var request = URLRequest(url: makeAccountsRequestURL())
        request.httpMethod = "GET"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
}
