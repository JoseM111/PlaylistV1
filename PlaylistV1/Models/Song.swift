import Foundation

class Song: Codable {
    
    var songTitle: String
    var artistName: String
    
    init(songTitle: String, artistName: String) {
        self.songTitle = songTitle
        self.artistName = artistName
    }
}

extension Song: Equatable {
    static func == (lhs: Song, rhs: Song) -> Bool {
        return lhs === rhs
    }
    
    
}
