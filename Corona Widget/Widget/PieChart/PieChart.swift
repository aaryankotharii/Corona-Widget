//
//  PieChart.swift
//  Corona Widget
//
//  Created by Aaryan Kothari on 24/07/20.
//

import SwiftUI
import Combine

struct PieChart: View {
    var pieChartData: PieChartData
    
    var body: some View {
        GeometryReader { geometry in
            self.makePieChart(geometry, pieChartData: self.pieChartData.data)
        }
    }
    
    func makePieChart(_ geometry: GeometryProxy, pieChartData: [SlideData]) -> some View {
        return ZStack {
            ForEach(0..<pieChartData.count, id: \.self) { index in
                PieChartSlide(geometry: geometry, slideData: pieChartData[index])
            }
        }
    }
}

struct PieChart_Previews: PreviewProvider {
    static var previews: some View {
        PieChart(pieChartData: PieChartData(data: [1, 2, 3],colors:[.coronapink,.coronagrey,.coronagreen]))
    }
}

