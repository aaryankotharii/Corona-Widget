//
//  LargeWidget.swift
//  Corona Widget
//
//  Created by Aaryan Kothari on 24/07/20.
//

import WidgetKit
import SwiftUI
import Intents

//MARK: systemLarge Widget

struct largeWidget : View {
    // MARK - PROPERTIES
    var data : CoronaData
    
    // MARK - BODY
    var body : some View {
        VStack{
            HStack{
                Image("global")
                    .resizable(capInsets: EdgeInsets(), resizingMode: .stretch)
                    .aspectRatio(contentMode: .fit)
                    .padding(.all,20)
            } //: HSTACK
            LargeWidgetBlock(data: data)
            Spacer()
            VStack(alignment:.leading){
                Text("TOP  10  MOST  AFFECTED  COUNTRIES  :-")
                    .font(.subheadline)
                    .foregroundColor(.coronapink)
                HStack{
                    ForEach(topTen(), id:\.self) { emoji in
                        Text(emoji)
                            .background(LinearGradient(gradient: Gradient(colors: [.red,.orange,.yellow]), startPoint: .bottomLeading, endPoint: .topTrailing))
                            .cornerRadius(5)
                    } //: FOREACH
                } //: HSTACK
                .padding(.bottom,30)
            } //: VSTACK
        }
    }
    
    /// function to find `Top 10` most affected countries
    func topTen()->[String]{
        let sorted = data.Countries.sorted { $0.TotalConfirmed >  $1.TotalConfirmed}
        let final = Array(sorted.prefix(10)).map { $0.CountryCode }
        let emojis = final.map { convertToEmoji(str: $0)}
        print(emojis)
        return emojis
    }
}

//END
