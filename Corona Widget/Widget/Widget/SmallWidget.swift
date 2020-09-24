//
//  SmallWidget.swift
//  Corona Widget
//
//  Created by Aaryan Kothari on 24/07/20.
//

import SwiftUI

//MARK: systemSmall Widget

struct smallWidget : View {
    // MARK - PROPERTIES
    var data : Countries
    
    // MARK - BODY
    var body : some View {
        VStack{
            HStack{
                Spacer()
                Text(data.emoji())
                Text(data.Country)
                Spacer()
            } //: HSTACK
            .font(.headline)
            .foregroundColor(.white)
            .padding(.top, 10)
            .padding(.all, 10)
            .background(Color.pink)
            
            VStack(alignment:.leading){
                smallWidgetBlock(type: .total, count: data.TotalConfirmed, color: .coronapink)
                smallWidgetBlock(type: .recovered, count: data.TotalRecovered, color: .coronagreen)
                smallWidgetBlock(type: .deaths, count: data.TotalRecovered, color: .coronagrey)
                smallWidgetBlock(type: .active, count: data.totalActive(), color: .coronayellow)
            } //: VSTACK
            .padding(.bottom, 15)
            Spacer()
        } //: VSTACK
    } //: BODY
}

//END
