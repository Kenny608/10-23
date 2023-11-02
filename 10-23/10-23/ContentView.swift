//
//  ContentView.swift
//  10-23
//
//  Created by Kenny Luchau on 11/2/23.
//

import SwiftUI
struct ContentView: View {
    @State var message = ""
    @State var results = ""
    @State var sliderValue = 0.0
    var body: some View {
        VStack {
            Button("Slider works??") {
                let startTime = Date()
                let queue = DispatchQueue.global(qos: .default)
                queue.async {
                    let fetchedData = self.fetchSomethingFromServer()
                    let processedData = self.processData(fetchedData)
                    var firstResult: String!
                    var secondResult: String!
                    let group = DispatchGroup()
                    queue.async(group: group) {
                        firstResult = self.calculateFirstResult(processedData)
                    }
                    queue.async(group: group) {
                        secondResult = self.calculateSecondResult(processedData)
                    }
                    group.notify(queue: queue) {
                        let resultsSummary = "First: [\(firstResult!)]\nSecond: [\(secondResult!)]"
                        let endTime = Date()
                        results = resultsSummary
                        message = "Completed in \(endTime.timeIntervalSince(startTime)) seconds"
                    }
                }
            }
            TextEditor(text: $results)
            Slider(value: $sliderValue)
            Text("Message = \(message)")
        }
    }
    func fetchSomethingFromServer() -> String {
            Thread.sleep(forTimeInterval: 3)
            return "HERE KENNY LIES OF P"
        }


        func processData(_ data: String) -> String {
            Thread.sleep(forTimeInterval: 3)
            return data.uppercased()
        }
        func calculateFirstResult(_ data: String) -> String {
            Thread.sleep(forTimeInterval: 3)
            let message = "Number of chars: \(String(data).count)"
            return message
        }
        func calculateSecondResult(_ data: String) -> String {
            Thread.sleep(forTimeInterval: 3)
            return data.replacingOccurrences(of: "E", with: "e")
        }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
