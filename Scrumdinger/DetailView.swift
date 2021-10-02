//
//  DetailView.swift
//  Scrumdinger
//
//  Created by Muhammad Fawwaz Mayda on 28/08/21.
//

import SwiftUI

struct DetailView: View {
    @Binding var scrum: DailyScrum
    @State var data: DailyScrum.Data = DailyScrum.Data()
    @State var isPresented = false
    
    var body: some View {
        List {
            Section(header: Text("Meeting Info")) {
                NavigationLink(
                    destination: MeetingView(scrum: $scrum)){
                    Label("Start meeting", systemImage: "timer")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                        .accessibility(label: Text("Start Meeting"))
                }
                HStack {
                    Label("Length", systemImage: "clock")
                        .accessibility(label: Text("Meeting Length"))
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes")
                }
                HStack {
                    Label("Color",systemImage: "paintpalette")
                    Spacer()
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(scrum.color)
                }.accessibilityElement(children: .ignore)
            }
            
            Section(header: Text("Attendees")) {
                ForEach(scrum.attendees, id: \.self) { attendee in
                    Label(attendee, systemImage: "person")
                        .accessibility(label: Text("Person"))
                        .accessibility(value: Text(attendee))
                }
            }
            
            Section(header: Text("History")) {
                if scrum.history.isEmpty {
                    Label("No meetings yet", systemImage: "calendar.badge.exclamationmark")
                }
                ForEach(scrum.history) { history in
                    NavigationLink(
                        destination: HistoryView(history: history),
                        label: {
                            HStack {
                                Image(systemName: "calendar")
                                Text(history.date,style: .date)
                            }
                        })
                }
            }
            
        }.listStyle(InsetGroupedListStyle())
        .navigationTitle(Text(scrum.title))
        .navigationBarItems(trailing: Button("Edit", action: {
            isPresented = true
            data = scrum.data
        }))
        .fullScreenCover(isPresented: $isPresented, content: {
            NavigationView {
                EditView(scrumData: $data)
                    .navigationTitle(scrum.title)
                    .navigationBarItems(leading: Button("Cancel", action: {
                        isPresented = false
                    }), trailing: Button("Done", action: {
                        isPresented = false
                        scrum.update(from: data)
                    }))
            }
        })
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(scrum: .constant(DailyScrum.data[0]))
        }
    }
}
