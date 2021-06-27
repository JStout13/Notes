//
// Swift Version 5.0
// macOS Version 11.4
//  CreditsView.swift
//  Notes WatchKit Extension
//
//  Created by Jason Stout on 6/26/21 . 
//  
//  Design is not just what it looks like and feels like. Design is how it works. - Steve Jobs
//  


import SwiftUI

struct CreditsView: View {
    
    var body: some View {
        VStack(spacing: 3) {
            Image("developer-no3")
                .resizable()
                .scaledToFit()
                .layoutPriority(1)
            
            HeaderView(title: "Credits")
            
            Text("Jason Stout")
                .foregroundColor(.primary)
                .fontWeight(.bold)
            Text("Developer")
                .font(.footnote)
                .fontWeight(.light)
                .foregroundColor(.secondary)
        }
    }
}

struct CreditsView_Previews: PreviewProvider {
    static var previews: some View {
        CreditsView()
    }
}
