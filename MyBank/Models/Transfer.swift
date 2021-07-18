//
//  Transfer.swift
//  MyBank
//
//  Created by Jakub Vodak on 17.07.2021.
//

import Foundation

struct Transfer: Codable {
    var sender: Account?
    var receiver: Float?
    var amount: Double?
}
