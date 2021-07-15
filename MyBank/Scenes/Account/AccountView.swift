//
//  AccountView.swift
//  MyBank
//
//  Created by Jakub Vodak on 13.07.2021.
//

import SwiftUI
import Combine

struct AccountView: View {
    @ObservedObject var viewModel: AccountViewModel
    private var cancellables: Set<AnyCancellable> = []
    
    init(viewModel: AccountViewModel) {
        self.viewModel = viewModel
        bindViewModel()
    }
    
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
    
    private mutating func bindViewModel() {
        viewModel.$accounts.sink { _ in
            
        }.store(in: &cancellables)
    }
}
