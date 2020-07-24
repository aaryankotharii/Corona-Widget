//
//  ContentView.swift
//  Corona Widget
//
//  Created by Aaryan Kothari on 21/07/20.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var corona = SessionStore()
    var body: some View {
        VStack{
            Spacer()
            Text("Hey There! 👋")
                .font(.system(size: 50, weight: .regular, design: .rounded))
            Spacer()
            VStack{
                Text("Total global cases:")
                    .font(.system(size: 20))
            Text("\(corona.current?.Global.TotalConfirmed ?? 0)")
                .font(.system(size: 50))
                .padding()
            }
            Spacer()
            buttonBar()
        }.edgesIgnoringSafeArea(.all)
        .background(LinearGradient(gradient: Gradient(colors: [.white, Color(#colorLiteral(red: 0.631372549, green: 0.6, blue: 1, alpha: 1))]), startPoint: .top, endPoint: .bottom))
        
        .onAppear(perform: fetch)
        
    }
    func fetch(){
        corona.fetch{ data in }
    }
}

struct buttonBar : View{
    var body : some View  {
        HStack{
            Link(destination: URL(string: "https://www.apple.com")!) {
                Image(systemName: "link.circle.fill")
                    .font(.largeTitle)
            }
            Link(destination: URL(string: "https://www.apple.com")!) {
                Image(systemName: "link.circle.fill")
                    .font(.largeTitle)
            }
            Link(destination: URL(string: "https://www.apple.com")!) {
                Image(systemName: "link.circle.fill")
                    .font(.largeTitle)
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
