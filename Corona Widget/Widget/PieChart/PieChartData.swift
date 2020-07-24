//
//  PieChartData.swift
//  Corona Widget
//
//  Created by Aaryan Kothari on 24/07/20.
//

import Foundation
import SwiftUI

class PieChartData: ObservableObject {
    @Published private(set) var data: [SlideData] = []
    
    init(data: [Double],colors : [Color]) {
        var currentAngle: Double = -90
        var slides: [SlideData] = []
        let total = data.reduce(0.0, +)
        
        for index in 0..<data.count {
            let slide = SlideData()
            let dataItem = DataItem(name: "Data name \(index + 1)", value: data[index], color: colors[index])
            dataItem.highlighted = index == 3
            slide.data = dataItem
            
            let percentage = data[index] / total * 100
            slide.annotation = String(format: "%.1f%", percentage)
            
            slide.startAngle = .degrees(currentAngle)
            let angle = data[index] * 360 / total
            let alpha = currentAngle + angle / 2
            currentAngle += angle
            slide.endAngle = .degrees(currentAngle)
            
            let deltaX = CGFloat(cos(abs(alpha).truncatingRemainder(dividingBy: 90.0) * .pi / 180.0))
            let deltaY = CGFloat(sin(abs(alpha).truncatingRemainder(dividingBy: 90.0) * .pi / 180.0))
            var padding: CGFloat = 0.0
            var paddingX: CGFloat = 0.0
            var paddingY: CGFloat = 0.0
            if slide.data.highlighted {
                padding = 0.15
                paddingX = deltaX * 20.0
                paddingY = deltaY * 20.0
            }
            
            let annotationDeltaX = deltaX * (0.7 + padding)
            let annotationDeltaY = deltaY * (0.7 + padding)
            if -90 <= alpha && alpha < 0 {
                slide.deltaX = paddingX
                slide.deltaY = -paddingY
                slide.annotationDeltaX = annotationDeltaX
                slide.annotationDeltaY = -annotationDeltaY
            } else if 0 <= alpha && alpha < 90 {
                slide.deltaX = paddingX
                slide.deltaY = paddingY
                slide.annotationDeltaX = annotationDeltaX
                slide.annotationDeltaY = annotationDeltaY
            } else if 90 <= alpha && alpha < 180 {
                slide.deltaX = -paddingY
                slide.deltaY = paddingX
                slide.annotationDeltaX = -annotationDeltaY
                slide.annotationDeltaY = annotationDeltaX
            } else {
                slide.deltaX = -paddingX
                slide.deltaY = -paddingY
                slide.annotationDeltaX = -annotationDeltaX
                slide.annotationDeltaY = -annotationDeltaY
            }
            
            slides.append(slide)
        }
        self.data = slides
    }
    
    init(data: [SlideData]) {
        self.data = data
    }
}
