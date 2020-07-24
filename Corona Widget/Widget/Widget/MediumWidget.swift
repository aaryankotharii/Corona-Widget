//
//  MediumWidget.swift
//  Corona Widget
//
//  Created by Aaryan Kothari on 24/07/20.
//

import SwiftUI

//MARK: systemMedium Widget

struct mediumWidget : View {
    var data : CountryData
    var body : some View {
        HStack{
            PieChart(pieChartData: PieChartData(data: [data.active, data.deaths, data.recovered],colors:[.coronagreen,.coronagrey,.coronayellow]))
                .padding(.all,25)
            Spacer()
            VStack(alignment:.leading){
                HStack{
                    Text(data.emoji)
                    Text(data.name)
                    Spacer()
                }.font(.system(size: 35))
                .foregroundColor(.black)
                .padding(.top,20)
                VStack(alignment:.leading) {
                    Text("Total: "+data.total.cases)
                        .foregroundColor(.coronapink)
                    Text("Recovered: "+data.recovered.cases)
                        .foregroundColor(.coronagreen)
                    Text("Deaths: "+data.deaths.cases)
                        .foregroundColor(.coronagrey)
                    Text("Active: "+data.active.cases)
                        .foregroundColor(.coronayellow)
                }
            }.padding(.bottom, 15)
        }
    }
}

//END
