//
//  ContentView.swift
//  FlightApp
//
//  Created by Александр Александрович on 19.10.2023.
//

import SwiftUI
import Coordinator

struct ContentView<ViewModel>: View where ViewModel: HomeViewModelProtocol {
    @ObservedObject private var vm: ViewModel
    @EnvironmentObject var coordinator: Coordinator<HomeRouter>

    init(vm: ViewModel) {
        self._vm = ObservedObject(wrappedValue: vm)
    }

    var body: some View {
        VStack {
            if vm.flights.isEmpty {
                ProgressView()
            } else {
                FlightlistTableView(flights: vm.flights)
                    .environmentObject(coordinator)
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
            HStack {
                Text(flight.startCity)
                Text(flight.endCity)
            }

            HStack {
                Text(flight.startDate)
                Text(flight.endDate)
            }
        }
        .padding()
    }
}

struct FlightlistTableView: View {
    @EnvironmentObject var coordinator: Coordinator<HomeRouter>
    let flights: [Flight]

    var body: some View {
        List {
            ForEach(flights) { flight in
                FlightRowView(flight: flight)
                    .onTapGesture {
                        print(flight.id)
                        coordinator.show(route: .detail)
                    }
            }
        }
    }
}

