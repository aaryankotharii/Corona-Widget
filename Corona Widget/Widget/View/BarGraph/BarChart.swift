//
//  BarChart.swift
//  Corona Widget
//
//  Created by Aaryan Kothari on 24/07/20.
//

import SwiftUI
import WidgetKit

/// `BarChart`

struct GraphView : View {
    var country : CountryData
    var body: some View {
        GeometryReader(content: { geometry in
            /// Vertical Stack of 4 lines
            VStack{
                BarLine(end: geometry.size.width * 0.75, value: country.total, color: .coronapink)
                BarLine(end: geometry.size.width * recoveredpercent(), value: country.active, color: .coronagreen)
                BarLine(end: geometry.size.width * deathPercent(), value: country.deaths, color: .coronagrey)
                BarLine(end: geometry.size.width * activepercent(), value: country.active, color: .coronayellow)
            }
        })
    }
    
    //Functions to calculate bar lenght.

    func activepercent()->CGFloat {
        return CGFloat(country.active/country.total) * 0.75
    }
    
    func deathPercent()->CGFloat {
        return CGFloat(country.deaths/country.total) * 0.75
    }
    
    func recoveredpercent()->CGFloat {
        return CGFloat(country.recovered/country.total) * 0.75
    }
    
}

//END
