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
            Text("\(Int(corona.current?.Global.TotalConfirmed ?? 0))")
                .font(.system(size: 50))
                .padding()
            }
            Spacer()
            buttonBar()
                .padding(.bottom, 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .background(LinearGradient(gradient: Gradient(colors: [.white, Color(#colorLiteral(red: 0.631372549, green: 0.6, blue: 1, alpha: 1))]), startPoint: .top, endPoint: .bottom))
        .onAppear(perform: fetch)
        .edgesIgnoringSafeArea(.all)
        
    }
    func fetch(){
        corona.fetch{ data in }
    }
}

struct buttonBar : View{
    var body : some View  {
        HStack(spacing:30){
            Link(destination: URL(string: "https://github.com/aaryankotharii")!) {
                Image("github")
                    .resizable()
                    .renderingMode(.original)
                    .scaledToFit()
                    .font(.largeTitle)
            }
            Link(destination: URL(string: "https://www.linkedin.com/in/aaryankotharii")!) {
                Image("LinkedIn")
                    .resizable()
                    .renderingMode(.original)
                    .scaledToFit()
                    .font(.largeTitle)
            }
            Link(destination: URL(string: "https://www.apple.com")!) {
                Image("mail")
                    .resizable()
                    .renderingMode(.original)
                    .scaledToFit()
                    .font(.largeTitle)
            }
        }.frame(height: 70, alignment: .center)
    }
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
