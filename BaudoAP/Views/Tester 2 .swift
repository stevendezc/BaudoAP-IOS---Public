//
//  Tester 2 .swift
//  BaudoAP
//
//  Created by Codez Studio on 27/07/23.
//
import SwiftUI

struct Tester_2: View {
    @State private var tabSelection = 0
    @State private var lastTapTime: Date?

    var body: some View {
        VStack {
            TabView(selection: $tabSelection) {
                // Your TabView content here
                Text("Tab 1")
                    .tag(0)
                Text("Tab 2")
                    .tag(1)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .gesture(
                TapGesture(count: 2)
                    .onEnded { _ in
                        if let lastTapTime = lastTapTime, abs(lastTapTime.timeIntervalSinceNow) < 0.5 {
                            // Perform the scrolling action here
                            print("ENTRE")
                            // For example, scroll ScrollView to the top
                        }
                        lastTapTime = Date()
                    }
            )

            ScrollView {
                // Your ScrollView content here
                VStack(spacing: 20) {
                    ForEach(1...100, id: \.self) { number in
                        Text("Item \(number)")
                            .padding()
                    }
                }
            }
        }
    }
}

struct Tester_2_Previews: PreviewProvider {
    static var previews: some View {
        Tester_2()
    }
}
