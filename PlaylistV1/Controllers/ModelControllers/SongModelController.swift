import Foundation

class SongModelController {
    
    static func createSong(playlist: Playlist, songTitle: String, artistName: String) {
        let newSong = Song(songTitle: songTitle, artistName: artistName)
        
        PlaylistModelController.shared.updatePlaylist(playlistToUpdate: playlist, song: newSong)
    }
}
