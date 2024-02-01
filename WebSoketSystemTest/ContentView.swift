//
//  ContentView.swift
//  WebSoketSystemTest
//
//  Created by Macvps on 1/31/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var webSocket = WebSocket()
    @State private var txt:String = "Some Text"
    var body: some View {
        VStack {
            TextField("Some Text",text: $txt)
//            List{
//                ForEach(0..<webSocket.strData.count,id:\.self) { i in
//                    Text(webSocket.strData[i])
//                }
//            }
            Spacer()
            Group{
                Button("Open Connection") {
                    webSocket.start()
                }
                Button("Close Connection") {
                    webSocket.close()
                }
                Button("Send Data") {
                    webSocket.send(txt)
                }
            }.padding(.vertical)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
