//
//  SlideData.swift
//  Corona Widget
//
//  Created by Aaryan Kothari on 24/07/20.
//

import Foundation
import SwiftUI

class SlideData: Identifiable, ObservableObject {
    let id: UUID = UUID()
    var data: DataItem!
    var startAngle: Angle! = .degrees(0)
    var endAngle: Angle! = .degrees(0)
    
    var annotation: String! = ""
    var annotationDeltaX: CGFloat! = 0.0
    var annotationDeltaY: CGFloat! = 0.0
    
    var deltaX: CGFloat! = 0.0
    var deltaY: CGFloat! = 0.0
    
    init() { }
    
    init(startAngle: Angle, endAngle: Angle) {
        self.data = DataItem(name: "", value: 0, color: .black)
        self.startAngle = startAngle
        self.endAngle = endAngle
    }
}

class DataItem {
    var name: String! = ""
    var value: Double = 0.0
    var color: Color! = .blue
    var highlighted: Bool = false
    
    init(name: String, value: Double, color: Color) {
        self.name = name
        self.value = value
        self.color = color
    }
}
