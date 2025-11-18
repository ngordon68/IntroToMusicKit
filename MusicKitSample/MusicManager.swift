//
//  MusicManager.swift
//  MusicKitSample
//
//  Created by Nick Gordon on 11/18/25.
//
import Observation
import MusicKit

@Observable
class MusicManager {
    
    var musicAuthorizationStatus: MusicAuthorization.Status
    var songs: [Song] = []
    var artistName: String = ""


    var musicPlayer: ApplicationMusicPlayer {
        ApplicationMusicPlayer.shared
    }

    
     init() {
         
        let authorizationStatus = MusicAuthorization.currentStatus
         musicAuthorizationStatus = authorizationStatus
    }
    
    func requestAuthorication() async {
      let result =  await MusicAuthorization.request()
        musicAuthorizationStatus = result
    }
    
    func playSong(_ song: Song) async {
       // let playback =
        let player = ApplicationMusicPlayer.shared
        do {
            player.queue = [song]
            try await player.play()
        } catch {
            print("error playing song")
        }
    }
    
    func loadSongs() async {
        var songRequest = MusicCatalogSearchRequest(
            term: artistName,
            types: [
                Artist.self,
                Album.self,
                Song.self
            ])
        
        do {
            let searchResponse = try await songRequest.response()
            print("searchResponse: \(searchResponse.songs)")
            let fetchedSongs = Array(searchResponse.songs)
            self.songs = fetchedSongs
        } catch {
            print("error getting song")
        }
    }

    }
