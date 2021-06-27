//
// Swift Version 5.0
// macOS Version 11.4
//  ContentView.swift
//  Notes WatchKit Extension
//
//  Created by Jason Stout on 6/26/21 . 
//  
//  Design is not just what it looks like and feels like. Design is how it works. - Steve Jobs
//  


import SwiftUI

struct ContentView: View {
    @State private var notes: [Note] = [Note]()
    @State private var text: String = ""
    @AppStorage("lineCount") var lineCount: Int = 1
    
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 6, content: {
                TextField("Add New Note", text: $text)
                
                Button(action: {
                    addNewNote()
                }, label: {
                    Image(systemName: "plus.circle")
                })
                .fixedSize()
                .buttonStyle(PlainButtonStyle())
                .foregroundColor(.accentColor)
                .font(.system(size: 42, weight: .semibold))
            })
            Spacer()
            
            if notes.count >= 1 {
                List {
                    ForEach(0..<notes.count, id: \.self) { i in
                        NavigationLink(destination: DetailView(note: notes[i], count: notes.count, index: i)) {
                            HStack {
                                Capsule()
                                    .frame(width: 4)
                                    .foregroundColor(.accentColor)
                                Text(notes[i].text)
                                    .lineLimit(lineCount)
                                    .padding(.leading, 5)
                            }
                        }
                    }
                    .onDelete(perform: deleteNote)
                }
            } else {
                Spacer()
                Image(systemName: "note.text")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
                    .opacity(0.25)
                    .padding(25)
                Spacer()
            }
        }
        .navigationTitle("Notes")
        .onAppear(perform: {
            loadNotes()
        })
    }
    
    func addNewNote() {
        guard text.isEmpty == false else { return }
        let note = Note(id: UUID(), text: text)
        notes.append(note)
        text = ""
        saveNotes()
    }
    
    func saveNotes() {
        do {
            let data = try JSONEncoder().encode(notes)
            let url = getDocumentDirectory().appendingPathComponent("notes")
            try data.write(to: url)
        } catch {
            print("Saving data has failed!")
        }
    }
    
    func loadNotes() {
        DispatchQueue.main.async {
            do {
                let url = getDocumentDirectory().appendingPathComponent("notes")
                let data = try Data(contentsOf: url)
                notes = try JSONDecoder().decode([Note].self, from: data)
            } catch {
                // do nothing
            }
        }
    }
    
    func deleteNote(offsets: IndexSet) {
        notes.remove(atOffsets: offsets)
        saveNotes()
    }
    
    func getDocumentDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
