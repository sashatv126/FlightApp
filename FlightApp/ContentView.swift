//
//  ContentView.swift
//  FlightApp
//
//  Created by Александр Александрович on 19.10.2023.
//

import SwiftUI

struct ContentView<ViewModel>: View where ViewModel: HomeViewModelProtocol {
    @ObservedObject private var vm: ViewModel

    init(vm: ViewModel) {
        self._vm = ObservedObject(wrappedValue: vm)
    }

    var body: some View {
        VStack {
            Text("sad")
            Button(vm.text) {
                vm.buttonTapped()
            }
        }
    }
}

#Preview {
    ContentView(vm: HomeViewModel())
}

