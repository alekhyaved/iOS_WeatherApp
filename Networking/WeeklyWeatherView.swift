//
//  WeeklyWeatherView.swift
//  HW1
//
//  Created by Arno Lenin Malyala on 3/31/20.
//  Copyright © 2020 Alekhya. All rights reserved.
//

import Foundation
import SwiftUI

struct WeeklyWeatherView: View {
    @ObservedObject var viewModel: WeeklyWeatherViewModel
    
    init(viewModel: WeeklyWeatherViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        //Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//        HStack {
//            if viewModel.dataSource.isEmpty {
//                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//                //emptySection
//            } else {
//                Text("Results: " + viewModel.displayWeatherInfo())
//            }
//        }
        NavigationView {
            List {
                HStack(alignment: .center) {
                    //TextField("e.g. Cupertino", text: $viewModel.city)
                    TextField("e.g. Cupertino", text: $viewModel.city, onEditingChanged: { (changed) in
                        print("City onEditingChanged - \(changed)")
                        //gets called when user taps on the TextField or taps return. The changed value is set to true when user taps on the TextField and it’s set to false when user taps return.
                    }) {
                        //The onCommit callback gets called when user taps return.
                        print("City onCommit")
                        //self.viewModel.fetchWeather(forCity: self.viewModel.city)
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                }
                if viewModel.dataSource.isEmpty {
                    Section {
                        Text("No results")
                            .foregroundColor(.gray)
                    }
                } else {
//                    Section {
//                        NavigationLink(destination: viewModel.currentWeatherView) {
//                            VStack(alignment: .leading) {
//                                Text(viewModel.city)
//                                Text("Weather today")
//                                    .font(.caption)
//                                    .foregroundColor(.gray)
//                            }
//                        }
//                    }
                    Section {
                        ForEach(viewModel.dataSource, content: DailyWeatherRow.init(viewModel:))
                    }
                }
                
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Weather ⛅️")
        }
    }
}

struct DailyWeatherRow: View {
    private let viewModel: DailyWeatherRowViewModel
    
    init(viewModel: DailyWeatherRowViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack {
            VStack {
                Text("\(viewModel.day)")
                Text("\(viewModel.month)")
            }
            
            VStack(alignment: .leading) {
                Text("\(viewModel.title)")
                    .font(.body)
                Text("\(viewModel.fullDescription)")
                    .font(.footnote)
            }
            .padding(.leading, 8)
            
            Spacer()
            
            Text("\(viewModel.temperature)°")
                .font(.title)
        }
    }
}

struct WeeklyWeatherView_Previews: PreviewProvider {
    //let datafetchpreview = DataFetcher()
    
    static var previews: some View {
        let weeklyviewModel = WeeklyWeatherViewModel(weatherFetcher: DataFetcher())
        return WeeklyWeatherView(viewModel: weeklyviewModel)
    }
}
