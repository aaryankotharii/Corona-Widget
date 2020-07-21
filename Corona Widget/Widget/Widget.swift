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
            GraphView(country: CountryModel(date: Date(), total: 100, active: 50, deaths: 30, recovered: 20, name: "", emoji: ""))
            Spacer()
        }
    }
}

struct GraphView : View {
    var country : CountryModel
    var body: some View {
        GeometryReader(content: { geometry in
            VStack{
                Line(end: geometry.size.width * 0.75, color: .coronapink)
                Line(end: geometry.size.width * recoveredpercent(), color: .coronagreen)
                Line(end: geometry.size.width * deathPercent(), color: .coronagrey)
                Line(end: geometry.size.width * activepercent(), color: .coronayellow)
            }
        })
    }
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


struct Line : View {
    var end : CGFloat
    var color : Color
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: 0, y: 20))
            path.addLine(to: CGPoint(x: Int(end), y: 20))
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
