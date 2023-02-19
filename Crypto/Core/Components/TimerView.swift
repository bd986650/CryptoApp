//
//  TimerView.swift
//  Crypto
//
//  Created by qwotic on 17.02.2023.
//

import SwiftUI

struct TimerView: View {
    
    @State private var nowDate: Date = Date()
    let setDate: Date
    var timer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.nowDate = Date()
        }
    }
    
    var body: some View {
        Text(time(from: setDate))
            .onAppear(perform: {self.timer})
    }
    
    func time(from date: Date) -> String {
        let calendar = Calendar(identifier: .gregorian)
        let timeValue = calendar.dateComponents([.hour, .minute, .second], from: nowDate, to: setDate)
        
        return String(format: "%02dh : %02dm : %02ds", timeValue.hour!, timeValue.minute!, timeValue.second!)
    }
}
