//
//  WebSocket.swift
//  WebSoketSystemTest
//
//  Created by Macvps on 1/31/24.
//

import Foundation

class WebSocket:NSObject,ObservableObject,URLSessionWebSocketDelegate{
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        print("Did Connected Socket")
        ping()
        receive()
    }
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        print("Connection Closed with Reason of:",reason ?? "")
    }
    private var webSocket:URLSessionWebSocketTask?
    init(webSocket: URLSessionWebSocketTask? = nil) {
        super.init()
        self.webSocket = webSocket
        start()
    }
    func session() -> URLSession{
        URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
    }
    func url() -> URL?{
        URL(string: "wss://socketsbay.com/wss/v2/1/demo/")
    }
    func start(){
        let session = session()
        let url = url()
        self.webSocket = session.webSocketTask(with: url!)
        self.webSocket?.resume()
        
    }
    func ping(){
        webSocket?.sendPing(pongReceiveHandler: { error in
            if let error = error{
                print("Ping Error:",error)
            }
        })
    }
    func close(){
        webSocket?.cancel(with: .goingAway, reason: "Demo Ended".data(using: .utf8))
    }
    func send(_ txt:String){
        self.webSocket?.send(.string(txt + " \(Int.random(in: 0...1000))"), completionHandler: { error in
            if let error = error {
                print("Error on Send is:",error)
            }
        })}
    func receive(){
        DispatchQueue.main.async{
            self.webSocket?.receive(completionHandler: { resualt in
                switch resualt {
                case .success(let message):
                    switch message{
                    case .data(let data):
                        print("Get Data:",data)
                    case .string(let message):
                        print("Get Message:",message)
                    @unknown default:
                        break
                    }
                case .failure(let error):
                    print("Recive Error:",error)
                }
            })
        }
    }
}





//Mark:Import
/*
closeButton.addTarget(self,
#selector(close), for: touchUpInside)


func urlSession_
session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
print( "Did
connect to socket")
ping)
receive ()
send o
func urlSession_
session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode,
reason: Data?) {
print("Did close connection with reason" )

*/
