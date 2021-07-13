//
//  AccountView.swift
//  MyBank
//
//  Created by Jakub Vodak on 13.07.2021.
//

import SwiftUI

struct AccountView: View {
    @ObservedObject var viewModel: AccountViewModel
    
    init(viewModel: AccountViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}
