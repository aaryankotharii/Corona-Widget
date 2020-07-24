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
    var annotation: String! = ""
    var startAngle: Angle! = .degrees(0)
    var endAngle: Angle! = .degrees(0)
}

class DataItem {
    var name: String! = ""
    var value: Double = 0.0
    var color: Color! = .blue
    
    init(name: String, value: Double, color: Color) {
        self.name = name
        self.value = value
        self.color = color
    }
}
