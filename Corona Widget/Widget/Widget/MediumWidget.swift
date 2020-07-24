//
//  MediumWidget.swift
//  Corona Widget
//
//  Created by Aaryan Kothari on 24/07/20.
//

import SwiftUI

//MARK: systemMedium Widget

struct mediumWidget : View {
    var data : Countries
    var body : some View {
        HStack{
            PieChart(pieChartData: PieChartData(data: [data.totalActive(), data.TotalDeaths, data.TotalRecovered],colors:[.coronagreen,.coronagrey,.coronayellow]))
                .padding(.all,25)
            Spacer()
            VStack(alignment:.leading){
                HStack{
                    Text(data.emoji())
                    Text(data.Country)
                    Spacer()
                }.font(.system(size: 35))
                .foregroundColor(.black)
                .padding(.top,20)
                VStack(alignment:.leading) {
                    Text("Total: "+data.TotalConfirmed.cases)
                        .foregroundColor(.coronapink)
                    Text("Recovered: "+data.TotalRecovered.cases)
                        .foregroundColor(.coronagreen)
                    Text("Deaths: "+data.TotalDeaths.cases)
                        .foregroundColor(.coronagrey)
                    Text("Active: "+data.totalActive().cases)
                        .foregroundColor(.coronayellow)
                }
            }.padding(.bottom, 15)
        }
    }
}

//END
