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
        .navigationTitle("Ticket List")
    }
}

struct TicketListRowView: View {

    let flight: FullInfoOfFlight

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(flight.airport.iataCode)
                    .font(.custom("Futura-Medium", size: 20.0, relativeTo: .title3))
                Text(flight.airport.address.cityName)
                    .font(.caption2)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
            }
            .padding(.leading, 8.0)
            Spacer()
            Image(systemName: "airplane")
                .resizable()
                .scaledToFit()
                .frame(width: 20.0)
                .foregroundColor(.blue)
            Spacer()
            VStack(alignment: .trailing) {
                Text(flight.flight.iataCode)
                    .font(.custom("Futura-Medium", size: 20.0, relativeTo: .title3))
                Text(flight.flight.name)
                    .font(.caption2)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8.0)
    }
}

struct FlightlistTableView: View {
    @EnvironmentObject var coordinator: Coordinator<HomeRouter>
    let flights: AllFlights

    var body: some View {
        List {
            ForEach(flights) { flight in
                TicketListRowView(flight: flight)
                    .onTapGesture {
                        print(flight.id)
                        coordinator.show(route: .detail)
                    }
            }
        }
    }
}

