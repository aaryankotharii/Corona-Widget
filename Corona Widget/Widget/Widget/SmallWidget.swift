//
//  SmallWidget.swift
//  Corona Widget
//
//  Created by Aaryan Kothari on 24/07/20.
//

import SwiftUI

//MARK: systemSmall Widget

struct smallWidget : View {
    var data : Countries
    var body : some View {
        VStack{
            HStack{
                Spacer()
                Text(data.emoji)
                Text(data.name)
                Spacer()
            }.font(.headline)
            .foregroundColor(.white)
            .padding(.top, 10)
            .padding(.all, 10)
            .background(Color.pink)
            VStack(alignment:.leading){
                smallWidgetBlock(type: .total, count: data.TotalConfirmed, color: .coronapink)
                smallWidgetBlock(type: .recovered, count: data.TotalRecovered, color: .coronagreen)
                smallWidgetBlock(type: .deaths, count: data.TotalRecovered, color: .coronagrey)
                smallWidgetBlock(type: .active, count: data.totalActive, color: .coronayellow)

            }.padding(.bottom, 15)
            Spacer()
        }
    }
}

struct smallWidgetBlock : View {
    var type : coronaType
    var count : Double
    var color : Color
    var body: some View {
        HStack {
            Image(type.image)
                .resizable(capInsets: EdgeInsets(), resizingMode: .stretch)
                .aspectRatio(contentMode: .fit)
            
            Text(type.rawValue)
                .minimumScaleFactor(0.5)
                .font(.system(size: 15))
                .lineLimit(1)
                .layoutPriority(1)
            Text(count.cases)
                .bold()
                .minimumScaleFactor(0.5)
                .lineLimit(1)
                .layoutPriority(1)
                .foregroundColor(color)
        }
    }
}

//END
