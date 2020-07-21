//
//  Widget.swift
//  Widget
//
//  Created by Aaryan Kothari on 22/07/20.
//

import WidgetKit
import SwiftUI
import Intents

struct CountryModel : TimelineEntry {
    var date: Date
    var total : Int
    var active : Int
    var deaths : Int
    var recovered : Int
    var name : String
    var emoji : String
}

struct DataProvider : TimelineProvider {
    func timeline(with context: Context, completion: @escaping (Timeline<CountryModel>) -> ()) {
        //TODO
    }
    
    func snapshot(with context: Context, completion: @escaping (CountryModel) -> ()) {
        // TODO
    }
}


struct WidgetView : View{
    var data : DataProvider.Entry
    @Environment(\.widgetFamily) var family

    var body : some View {
        VStack{
            HStack{
                Spacer()
                Text(data.emoji)
                Text(data.name)
                Spacer()
            }
            .padding(.all, 10)
            .background(Color.pink)
            VStack(spacing:10){
                Line(end: 90, color: Color.coronapink)
                Line(end: 50, color: Color.coronagreen)
                Line(end: 10, color: Color.coronagrey)
                Line(end: 30, color: Color.coronayellow)

            }
            Spacer()
        }
    }
}


struct Line : View {
    var end : Int
    var color : Color
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: 0, y: 20))
            path.addLine(to: CGPoint(x: end, y: 20))
        }
        .stroke(color, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
    }
}

struct Placeholder : View{
    var body : some View {
        Text("YO")
    }
}

@main
struct Config : Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "Widget", provider: DataProvider(), placeholder: Placeholder()) { data in
            WidgetView(data: data)
        }
        .supportedFamilies([.systemSmall])
        .description(Text("Current Time widget"))
    }
}


struct Widget_Previews: PreviewProvider {
    static var previews: some View {
        WidgetView(data: CountryModel(date: Date(), total: 10, active: 20, deaths: 20, recovered: 10,name: "India",emoji: "🇮🇳"))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
