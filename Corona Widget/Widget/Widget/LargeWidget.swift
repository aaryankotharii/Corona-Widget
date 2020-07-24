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
    var data : CoronaData
    var body : some View {
        VStack{
            HStack{
                Image("global")
                    .resizable(capInsets: EdgeInsets(), resizingMode: .stretch)
                    .aspectRatio(contentMode: .fit)
                    .padding(.all,20)
            }
            VStack(alignment:.leading){
                countStack(total: data.Global.TotalConfirmed,color: .coronapink, name: "confirmed")
                countStack(total: data.Global.TotalRecovered,  color: .coronagreen, name: "recovered")
                countStack(total: data.Global.TotalDeaths,color: .coronagrey, name: "deaths")
                countStack(total: totalActive(),color: .coronayellow, name: "active")
            }

            VStack(alignment:.leading){
                countStack(total: data.Global.NewConfirmed,color: .coronapink, name: "confirmed",isActive: true,type: .total)
                countStack(total: data.Global.NewRecovered, color: .coronagreen, name: "recovered",isActive: true,type: .recovered)
                countStack(total: data.Global.NewDeaths,color: .coronagrey, name: "deaths",isActive: true,type: .deaths)
            }
            
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
                }
            }.padding(.bottom,30)
        }
        }
    }
    
    func totalActive()-> Double{
        return data.Global.TotalConfirmed - data.Global.TotalDeaths - data.Global.TotalRecovered
    }
    
    func topTen()->[String]{
    let sorted = data.Countries.sorted { $0.TotalConfirmed >  $1.TotalConfirmed}
        let final = Array(sorted.prefix(10)).map { $0.CountryCode }
        let emojis = final.map { convertToEmoji(str: $0)}
        print(emojis)
     return emojis
    }
}

struct countStack : View {
    let total : Double
    let color : Color
    let name : String
    var isActive = false
    var type : coronaType = .total
    var body: some View {
        HStack{
            Group{
                if isActive{
                    Image(type.image)
                        .resizable(capInsets: EdgeInsets(), resizingMode: .stretch)
                        .aspectRatio(contentMode: .fit)
                }
            }
            Text((isActive ? "New " : "Total ") + "\(name) : \(Int(total))").bold()
        }
    }
}



//END
