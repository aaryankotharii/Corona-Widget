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
            Text("Hey There! 👋")
                .font(.system(size: 100, weight: .regular, design: .rounded))
            Text("\(corona.current?.Global.TotalConfirmed ?? 0)").padding()
        }.edgesIgnoringSafeArea(.all)
        .background(LinearGradient(gradient: Gradient(colors: [.white, Color(#colorLiteral(red: 0.631372549, green: 0.6, blue: 1, alpha: 1))]), startPoint: .top, endPoint: .bottom))
        
        .onAppear(perform: fetch)
        
    }
    func fetch(){
        corona.fetch{ data in }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
