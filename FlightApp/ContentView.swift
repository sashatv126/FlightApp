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
            if vm.flights.isEmpty {
                ProgressView()
            } else {
                FlightlistTableView(flights: vm.flights)
            }
        }
        .onAppear(perform: {
            vm.viewDidAppear()
        })
    }
}

struct FlightRowView: View {
    let flight: Flight

    var body: some View {
        VStack {
            Text(flight.startCity)
            Text(flight.endCity)
            Text(flight.startDate)
            Text(flight.endDate)
            Text(flight.serviceClass)
            Text(flight.startLocationCode)
        }
        .padding()
    }
}

struct FlightlistTableView: View {
    let flights: [Flight]

    var body: some View {
        List {
            ForEach(flights) { flight in
                FlightRowView(flight: flight)
            }
        }
    }
}

