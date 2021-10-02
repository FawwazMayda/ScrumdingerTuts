//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by Muhammad Fawwaz Mayda on 28/08/21.
//

import SwiftUI

struct ScrumsView: View {
    @Binding var scrums: [DailyScrum]
    @State private var isPresented = false
    @State var newDailyScrum = DailyScrum.Data()
    @Environment(\.scenePhase) private var scenePhase
    let saveAction: () -> Void
    
    var body: some View {
        List {
            ForEach(scrums) {scrum in
                NavigationLink(destination: DetailView(scrum: binding(for: scrum))) {
                    CardView(scrum: scrum)
                }.listRowBackground(scrum.color)
            }
        }.navigationTitle(Text("Daily Scrums"))
        .navigationBarItems(trailing: Button(action: {isPresented = true}, label: {
            Image(systemName: "plus")
        })).sheet(isPresented: $isPresented) {
            NavigationView {
                EditView(scrumData: $newDailyScrum)
                    .navigationBarItems(leading: Button("Dismiss", action: {
                        isPresented = false
                    }), trailing: Button("Add", action: {
                        let newScrum = DailyScrum(title: newDailyScrum.title, attendees: newDailyScrum.attendees, lengthInMinutes: Int(newDailyScrum.lengthInMinutes), color: newDailyScrum.color)
                        
                        scrums.append(newScrum)
                        isPresented = false
                    }))
            }
        }.onChange(of: scenePhase, perform: { phase in
            if phase == .inactive {saveAction()}
        })
    }
    
    private func binding(for scrum: DailyScrum) -> Binding<DailyScrum> {
        guard let scrumIndex = scrums.firstIndex(where: { $0.id == scrum.id}) else {
            fatalError("Cant find the index")
        }
        
        return $scrums[scrumIndex]
    }
}

struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ScrumsView(scrums: .constant(DailyScrum.data), saveAction: {})
        }
    }
}
