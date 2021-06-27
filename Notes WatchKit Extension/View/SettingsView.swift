//
// Swift Version 5.0
// macOS Version 11.4
//  SettingsView.swift
//  Notes WatchKit Extension
//
//  Created by Jason Stout on 6/26/21 . 
//  
//  Design is not just what it looks like and feels like. Design is how it works. - Steve Jobs
//  


import SwiftUI

struct SettingsView: View {
    @AppStorage("lineCount") var lineCount: Int = 1
    @State private var value: Float = 1.0
    
    var body: some View {
        VStack(spacing: 8) {
            HeaderView(title: "Settings")
            Text("Lines: \(lineCount)".uppercased())
                .fontWeight(.bold)
            Slider(value: Binding(get: {
                Double(self.lineCount)
            }, set: {(newValue) in
                self.value = Float(newValue)
                self.update()
            }), in: 1...4, step: 1)
                .accentColor(.accentColor)
        }
    }
    func update() {
        lineCount = Int(value)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
