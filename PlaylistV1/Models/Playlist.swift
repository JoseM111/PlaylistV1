import Foundation

class Playlist: Codable {
    
    // MARK: @Properties
    var playlistName: String
    var songs: [Song]
    
    init(playlistName: String, songs: [Song] = []) {
        
        self.playlistName = playlistName
        self.songs = songs
    }
}

extension Playlist: Equatable {
    static func == (lhs: Playlist, rhs: Playlist) -> Bool {
        return lhs === rhs
    }
}
