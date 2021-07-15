//
//  AccountError.swift
//  MyBank
//
//  Created by Jakub Vodak on 15.07.2021.
//

import Foundation

enum AccountError: Error {
  case parsing(description: String)
  case network(description: String)
}
