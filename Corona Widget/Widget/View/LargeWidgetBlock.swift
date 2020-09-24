//
//  LargeWidgetBlock.swift
//  WidgetExtension
//
//  Created by Aaryan Kothari on 24/09/20.
//

import SwiftUI

struct LargeWidgetBlock: View {
    // MARK - PROPERTIES
    var data : CoronaData
    
    // MARK - BODY
    var body: some View {
        VStack{
            VStack(alignment:.leading){
                countStack(total: data.Global.TotalConfirmed,color: .coronapink, name: "confirmed")
                countStack(total: data.Global.TotalRecovered,  color: .coronagreen, name: "recovered")
                countStack(total: data.Global.TotalDeaths,color: .coronagrey, name: "deaths")
                countStack(total: totalActive(),color: .coronayellow, name: "active")
            } //: VSTACK
            VStack(alignment:.leading){
                countStack(total: data.Global.NewConfirmed,color: .coronapink, name: "confirmed",isActive: true,type: .total)
                countStack(total: data.Global.NewRecovered, color: .coronagreen, name: "recovered",isActive: true,type: .recovered)
                countStack(total: data.Global.NewDeaths,color: .coronagrey, name: "deaths",isActive: true,type: .deaths)
            } //: VSTACK
        } //: VSTACK
    }
}

struct countStack : View {
    // MARK - PROPERTIES
    let total : Double
    let color : Color
    let name : String
    var isActive = false
    var type : coronaType = .total
    
    // MARK - BODY
    var body: some View {
        HStack{
            Group{
                if isActive{
                    Image(type.image)
                        .resizable(capInsets: EdgeInsets(), resizingMode: .stretch)
                        .aspectRatio(contentMode: .fit)
                } //: IF
            } //: GROUP
            Text((isActive ? "New " : "Total ") + "\(name) : \(Int(total))").bold()
        } //: HSTACK
    } //: BODY
}
