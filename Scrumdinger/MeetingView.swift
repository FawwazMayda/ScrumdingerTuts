/*
See LICENSE folder for this sample’s licensing information.
*/

import SwiftUI
import AVFoundation

struct MeetingView: View {
    @Binding var scrum: DailyScrum
    @StateObject var scrumTimer = ScrumTimer()
    @State private var transcript = ""
    @State private var isRecording = false
    let speechRecognizer = SpeechRecognizer()
    var player: AVPlayer = AVPlayer.sharedDingPlayer
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16.0)
                .fill(scrum.color)
            VStack {
                ProgressView(value: 5, total: 15)
                MeetingHeaderView(secondsElapsed: scrumTimer.secondsElapsed, secondRemaining: scrumTimer.secondsRemaining, scrumColor: scrum.color)
                
                MeetingTimerView(speakers: scrumTimer.speakers, scrumColor: scrum.color, isRecording: isRecording)
                
                MeetingFooterView(speakers: scrumTimer.speakers, skipAction: scrumTimer.skipSpeaker)
                
            }
        }.padding()
        .foregroundColor(scrum.color.accessibleFontColor)
        .onAppear(perform: {
            speechRecognizer.record(to: $transcript)
            scrumTimer.reset(lengthInMinutes: scrum.lengthInMinutes, attendees: scrum.attendees)
            scrumTimer.speakerChangedAction = {
                player.seek(to: .zero)
                player.play()
            }
            scrumTimer.startScrum()
            isRecording = true
        })
        .onDisappear(perform: {
            speechRecognizer.stopRecording()
            scrumTimer.stopScrum()
            let newHistory = History(attendees: scrum.attendees, lengthInMinutes: scrum.lengthInMinutes / 60, transcript: transcript)
            scrum.history.append(newHistory)
            isRecording = false
        })
    }
}

struct MeetingView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView(scrum: .constant(DailyScrum.data[0]))
    }
}
