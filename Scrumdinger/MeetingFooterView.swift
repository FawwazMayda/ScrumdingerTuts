//
//  MeetingFooterView.swift
//  Scrumdinger
//
//  Created by Muhammad Fawwaz Mayda on 01/10/21.
//

import SwiftUI

struct MeetingFooterView: View {
    let speakers: [ScrumTimer.Speaker]
    var skipAction: () -> Void
    
    private var speakerNumber: Int? {
        guard let speakerIndex = speakers.firstIndex(where: {!$0.isCompleted}) else {return nil}
        return speakerIndex + 1
    }
    
    private var isLastSpeaker: Bool {
        return speakers.dropLast().allSatisfy{$0.isCompleted}
    }
    
    private var speakterText: String {
        guard let speakerNumber = speakerNumber else {return "No more speakers"}
        return "Speaker: \(speakerNumber) out of \(speakers.count)"
    }
    
    var body: some View {
        VStack {
            HStack {
                if isLastSpeaker {
                    Text("Last Speaker")
                } else {
                    Text(speakterText)
                    Spacer()
                    Button(action: skipAction) {
                        Image(systemName:"forward.fill")
                    }
                    .accessibilityLabel(Text("Next speaker"))
                }
            }
        }.padding([.bottom, .horizontal], /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
    }
}

struct MeetingFooterView_Previews: PreviewProvider {
    static var speakers = [ScrumTimer.Speaker(name: "Kim", isCompleted: false), ScrumTimer.Speaker(name: "Bill", isCompleted: false)]
    static var previews: some View {
        MeetingFooterView(speakers: speakers,skipAction: {})
            .previewLayout(.sizeThatFits)
    }
}
