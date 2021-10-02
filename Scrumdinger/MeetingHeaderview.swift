//
//  MeetingHeaderview.swift
//  Scrumdinger
//
//  Created by Muhammad Fawwaz Mayda on 01/10/21.
//

import SwiftUI

struct MeetingHeaderView: View {
    let secondsElapsed: Int
    let secondRemaining: Int
    let scrumColor: Color
    
    private var progress: Double {
        guard secondRemaining > 0 else {return 1.0}
        let totalSeconds = (secondsElapsed + secondRemaining)
        return Double(secondsElapsed) / Double(totalSeconds)
    }
    
    private var minutesRemaining: Int {
        return secondRemaining / 60
    }
    
    private var minutesRemainingMetric: String {
        return (minutesRemaining == 1) ? "minute" : "minutes"
    }
    
    var body: some View {
        VStack {
            ProgressView(value: progress)
                .progressViewStyle(ScrumProgressViewStyle(scrumColor: scrumColor))
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Seconds Elapsed").font(.caption)
                    Label("\(secondsElapsed)", systemImage: "hourglass.bottomhalf.fill")
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Seconds Remaining").font(.caption)
                    HStack {
                        Text("\(secondRemaining)")
                        Image(systemName: "hourglass.tophalf.fill")
                    }
                }
            }
        }.accessibilityElement(children: .ignore)
            .accessibility(label: Text("Time remaining"))
        .accessibility(value: Text("\(minutesRemaining) \(minutesRemainingMetric)"))
        .padding([.top,.horizontal])
    }
}

struct MeetingHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingHeaderView(secondsElapsed: 30, secondRemaining: 200,scrumColor: DailyScrum.data[0].color)
            .previewLayout(.sizeThatFits)
    }
}


