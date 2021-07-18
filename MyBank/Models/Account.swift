//
//  Account.swift
//  MyBank
//
//  Created by Jakub Vodak on 13.07.2021.
//

import Foundation

struct Account: Codable {
    let name: String?
    let number: UInt?
    let currency: String?
    let balance: Double?
}
