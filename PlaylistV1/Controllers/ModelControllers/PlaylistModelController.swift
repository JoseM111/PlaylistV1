import Foundation

class PlaylistModelController {
    
    // MARK: @Properties-Source of truth
    var playlists: [Playlist] = []
    
    // MARK: _shared-instance
    static let shared = PlaylistModelController()
    
    /**©------------------------------------------------------------------------------©*/
    // MARK: _CRUD
    
    
    // CREATE Add method signatures
    func createPlaylist(playlistName: String) {
        let newPlaylist = Playlist(playlistName: playlistName)
        
        playlists.append(newPlaylist)
        
        saveToPersistentStorage()
    }
    
    /// READ() if we have data to read
    // UPDATE Add method signatures
    func updatePlaylist(playlistToUpdate playlist: Playlist, song: Song) {
        playlist.songs.append(song)
        
        saveToPersistentStorage()
    }
   
    
    // DELETE Add method signatures
    func deletePlaylist(playlistTodelete playlist: Playlist) {
        guard let indexToDelete = playlists.firstIndex(of: playlist) else { return }
        playlists.remove(at: indexToDelete)
        
        saveToPersistentStorage()
    }
    
    // Delete a song
    func deleteSongFrom(playlist: Playlist, songToDelete song: Song) {
        guard let indexToDelete = playlist.songs.firstIndex(of: song) else { return }
        playlist.songs.remove(at: indexToDelete)
        
        saveToPersistentStorage()
    }
    
    // Saving an array of data of the object
    // We want to save the persistence everytime we make a change or close your phone.
    // So this code below (URL)--> Uniform Resource Locator
    func fileURL() -> URL {
        // User document directory
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = urls[0].appendingPathComponent("playlistV1.json")
        return fileURL
    }
    // The purpose of this function is to write the data to the file location
    func saveToPersistentStorage() {
        
        let jsonEncoder = JSONEncoder()
        do { // Needs to conform to typealias Codable = Decodable & Encodable
            let data = try jsonEncoder.encode(playlists)
            try data.write(to: fileURL()) // writes to file
            
        } catch {// No ned for let error. Catch has it by default
            
            print(error.localizedDescription)
        }
    }
    // This function actually loads the persistence
    func loadFromPersistence() {
        let jsonDecoder = JSONDecoder()
        do {
            let decodeData = try Data(contentsOf: fileURL())
            // [Contact].self Telling the decoder what type of object to return
            self.playlists = try jsonDecoder.decode([Playlist].self, from: decodeData)
        } catch {
            print(error.localizedDescription)
        }
    }
    /* MAKE SURE YOU SAVE TO PERSISTENCE ON ALL CRUD FUNCTIONS */
    
    /**©------------------------------------------------------------------------------©*/
    
    
}
