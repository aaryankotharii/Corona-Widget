//
//  SmallWidgetBlock.swift
//  WidgetExtension
//
//  Created by Aaryan Kothari on 24/09/20.
//

import SwiftUI

struct smallWidgetBlock : View {
    // MARK - PROPERTIES
    var type : coronaType
    var count : Double
    var color : Color
    
    // MARK - BODY
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
        } //: HSTACK
    } //: BODY
}
