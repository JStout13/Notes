//
// Swift Version 5.0
// macOS Version 11.4
//  DetailView.swift
//  Notes WatchKit Extension
//
//  Created by Jason Stout on 6/26/21 . 
//  
//  Design is not just what it looks like and feels like. Design is how it works. - Steve Jobs
//  


import SwiftUI

struct DetailView: View {
    @State private var isCrteditsPresented: Bool = false
    @State private var isSettingsPresented: Bool = false
    let note: Note
    let count: Int
    let index: Int
    
    var body: some View {
        VStack(alignment: .center, spacing: 3) {
            HeaderView(title: "")
            
            Spacer()
            
            ScrollView(.vertical) {
                Text(note.text)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
            }
            Spacer()
            HStack(alignment: .center) {
                Image(systemName: "gear")
                    .imageScale(.large)
                    .onTapGesture {
                        isSettingsPresented.toggle()
                    }
                    .sheet(isPresented: $isSettingsPresented, content: {
                        SettingsView()
                    })
                Spacer()
                Text("\(count) / \(index + 1)")
                Spacer()
                Image(systemName: "info.circle")
                    .imageScale(.large)
                    .onTapGesture {
                        isCrteditsPresented.toggle()
                    }
                    .sheet(isPresented: $isCrteditsPresented, content: {
                        CreditsView()
                    })
            }
            .foregroundColor(.secondary)
        }
        .padding(3)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var sampleData: Note = Note(id: UUID(), text: "Hello this is my note for the detail preview.")
    static var previews: some View {
        DetailView(note: sampleData, count: 5, index: 1)
    }
}
