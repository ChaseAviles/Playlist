//
//  SongController.swift
//  Playlist
//
//  Created by Johnathan Aviles on 1/11/21.
//

import Foundation

class SongController{
    
    //shared instance
    static let shared = SongController()
    
    //source of truth (S.O.T)
    var songs: [Song] = []
    
    //CRUD
    //create
    func createSong(title: String, artist: String){
        //create a song
        let newSong = Song(title: title, artist: artist)
        // add it to songs array
        songs.append(newSong)
        //save
        saveToPersistenceStore()
    }
    
    //Read
    
    // TODO: - Update
    
    //Delete
    func deleteSong(songToDelete: Song){
        // remove song from songs array
        guard let index = songs.firstIndex(of: songToDelete) else { return }
        songs.remove(at: index)
        // save changes
        saveToPersistenceStore()
    }
    
    // MARK: - Persistence
    
    // fileURL function to save and load from
    func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = urls[0].appendingPathComponent("Playlist.json")
        return fileURL
    }
    
    //save
    func saveToPersistenceStore(){
        do {
            let data = try JSONEncoder().encode(songs)
            try data.write(to: fileURL())
        } catch{
            print(error.localizedDescription)
        }
        
    }
    //load
    func loadFromPersistenceStore(){
        do{
            let data = try Data(contentsOf: fileURL())
            songs = try JSONDecoder().decode([Song].self, from: data)
        } catch{
            print(error)
            print(error.localizedDescription)
        }
    }
    
    
}
