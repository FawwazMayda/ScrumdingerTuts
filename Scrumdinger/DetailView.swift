//
//  DetailView.swift
//  Scrumdinger
//
//  Created by Muhammad Fawwaz Mayda on 28/08/21.
//

import SwiftUI

struct DetailView: View {
    let scrum: DailyScrum
    @State var isPresented = false
    
    var body: some View {
        List {
            Section(header: Text("Meeting Info")) {
                NavigationLink(
                    destination: MeetingView()){
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
        }.listStyle(InsetGroupedListStyle())
        .navigationTitle(Text(scrum.title))
        .navigationBarItems(trailing: Button("Edit", action: {
            isPresented = true
        }))
        .fullScreenCover(isPresented: $isPresented, content: {
            NavigationView {
                EditView()
                    .navigationTitle(scrum.title)
                    .navigationBarItems(leading: Button("Cancel", action: {
                        isPresented = false
                    }), trailing: Button("Done", action: {
                        isPresented = false
                    }))
            }
        })
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(scrum: DailyScrum.data[0])
        }
    }
}
