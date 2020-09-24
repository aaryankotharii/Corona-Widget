//
//  MediumWidgetBlock.swift
//  WidgetExtension
//
//  Created by Aaryan Kothari on 24/09/20.
//

import SwiftUI

struct MediumWidgetBlock: View {
    // MARK - PROPERTIES
    var data : Countries

    // MARK - BODY
    var body: some View {
        VStack(alignment:.leading){
            HStack{
                Text(data.emoji())
                Text(data.Country)
                Spacer()
            } //: HSTACK
            .font(.system(size: 35))
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
            } //: VSTACK
        } //: VSTACK
        .padding(.bottom, 15)
    } //: BODY
}
