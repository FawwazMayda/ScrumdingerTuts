//
//  EditView.swift
//  Scrumdinger
//
//  Created by Muhammad Fawwaz Mayda on 31/08/21.
//

import SwiftUI

struct EditView: View {
    @Binding var scrumData: DailyScrum.Data
    @State private var newAttendee = ""
    var body: some View {
        List {
            Section(header: Text("Meeting Info")) {
                
                TextField("Title", text: $scrumData.title)
                
                HStack {
                    Slider(value: $scrumData.lengthInMinutes, in: 5...30, step: 1.0) {
                        Text("Meeting Progress")
                    }.accessibility(value: Text("\(Int(scrumData.lengthInMinutes)) minutes"))
                    Spacer()
                    Text("\(Int(scrumData.lengthInMinutes)) minutes").accessibility(hidden: true)
                }
                ColorPicker("Color", selection: $scrumData.color)
                    .accessibility(value: Text("Color picker"))
            }
            
            Section(header: Text("Attendees")) {
                
                ForEach(scrumData.attendees, id:\.self) {attendee in
                    Text(attendee)
                }.onDelete(perform: { indexSet in
                    scrumData.attendees.remove(atOffsets: indexSet)
                })
                
                HStack {
                    TextField("New Attendee", text: $newAttendee)
                    
                    Button(action: {
                        withAnimation {
                            scrumData.attendees.append(newAttendee)
                            newAttendee = ""
                        }
                    }, label: {
                        Image(systemName: "plus.circle.fill").accessibility(value: Text("add attendee"))
                    }).disabled(newAttendee.isEmpty)
                }
            }
        }.listStyle(InsetGroupedListStyle())
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(scrumData: .constant(DailyScrum.data[1].data))
    }
}
