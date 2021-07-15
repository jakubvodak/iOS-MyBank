//
//  AccountFetcher.swift
//  MyBank
//
//  Created by Jakub Vodak on 13.07.2021.
//

import Foundation
import Combine

protocol AccountFetchable {
    
}

class AccountFetcher {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
}

extension AccountFetcher: AccountFetchable {
    
    func fetchAccounts() {
        session.dataTask(with: makeAccountRequest()) { (data, response, error) in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    let error = AccountError.network(description: error.localizedDescription)
                }
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
