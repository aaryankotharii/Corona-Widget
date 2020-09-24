//
//  MediumWidget.swift
//  Corona Widget
//
//  Created by Aaryan Kothari on 24/07/20.
//

import SwiftUI

//MARK: systemMedium Widget

struct mediumWidget : View {
    // MARK - PROPERTIES
    var data : Countries
    
    // MARK - BODY
    var body : some View {
        HStack{
            PieChart(pieChartData: PieChartData(data: [data.totalActive(), data.TotalDeaths, data.TotalRecovered],colors:[.coronayellow,.coronagrey,.coronagreen]))
                .padding(.all,25)
            Spacer()
            MediumWidgetBlock(data: data)
        } //: HSTACK
    } //: BODY
}

//END
