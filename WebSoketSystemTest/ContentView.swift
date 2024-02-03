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
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        VStack {
            TextField("Some Text",text: $txt)
            HStack{
                List {
                    ForEach(0..<webSocket.data.count,id:\.self){ i in
                        Text(webSocket.data[i])
                    }
                    ForEach(0..<webSocket.strData.count,id:\.self){ i in
                        Text(webSocket.strData[i])
                    }
                }
            }.padding()
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
                Button("Start Reciveing") {
                    timer = timer.upstream.autoconnect()
                }
                Button("Stop Reciveing") {
                    timer.upstream.connect().cancel()
                }
            }.padding(.vertical)
                .onReceive(timer, perform: { _ in
                    if webSocket.sucssedConnection{
                        webSocket.receive()
                        webSocket.ping()
                    }
                })
                .onAppear{
                    timer.upstream.connect().cancel()
                }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
