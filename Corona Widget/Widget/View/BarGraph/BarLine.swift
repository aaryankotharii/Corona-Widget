//
//  BarLine.swift
//  Corona Widget
//
//  Created by Aaryan Kothari on 24/07/20.
//

import SwiftUI

/// Line used in `BarChart`
/// `Start`  : starting point of line
/// `End`  : ending point of line
/// `color`  : color of line
/// `value`  :  Value of coronatype

struct BarLine : View {
    var end : CGFloat
    var value : Double
    var color : Color

    var body: some View {
        HStack{
            Path { path in
                path.move(to: CGPoint(x: 0, y: 20))
                path.addLine(to: CGPoint(x: Int(end), y: 20))
            }
            .stroke(color, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
        }
    }
}

///END
