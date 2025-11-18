//
//  ContentView.swift
//  MusicKitSample
//
//  Created by Nick Gordon on 11/16/25.
//

import SwiftUI
import MusicKit

struct ContentView: View {
    @State var musicManager = MusicManager()
    
    var body: some View {
        VStack {
            Text("Enter Artist Here")
                .font(.largeTitle)
                .bold()
            
            TextField("Enter Artist Name", text: $musicManager.artistName)
                .textFieldStyle(.roundedBorder)
            
            Button("load songs") {
                Task {
                   await musicManager.loadSongs()
                }
            }
            .buttonStyle(.bordered)
            .tint(.orange)
            
            List(musicManager.songs, id: \.self) { song in
                HStack {
                    VStack(alignment: .leading) {
                        Text(song.title)
                        Text(song.artistName)
                        
                    }
                    Spacer()
                    
                    Button("play song") {
                        Task {
                            await musicManager.playSong(song)
                        }
                    }
                }
            }
        }
        .padding()
        .task {
            await musicManager.requestAuthorication()
        }
    }
}

#Preview {
    ContentView()
}
