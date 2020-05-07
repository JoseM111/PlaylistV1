import UIKit

class SongTableViewController: UITableViewController {
    
    // MARK: _@IBOutlet
    @IBOutlet weak var songNameTextField: UITextField!
    @IBOutlet weak var artistNameTextField: UITextField!
    
    
    // MARK: @Properties
    var playlist: Playlist?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: _@IBAction
    @IBAction func createSongButtonTapped(_ sender: Any) {
        guard let playlist = playlist,
            let songName = songNameTextField.text, !songName.isEmpty,
            let artistName = artistNameTextField.text, !artistName.isEmpty else { return }
        
        SongModelController.createSong(playlist: playlist, songTitle: songName, artistName: artistName)
        
        songNameTextField.text = ""
        artistNameTextField.text = ""
        tableView.reloadData()
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let playlist = playlist else { return 0 }
        return playlist.songs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)
        
        guard let playlist = playlist else { return UITableViewCell() }
        
        let song = playlist.songs[indexPath.row]
        // Configure the cell...
        cell.textLabel?.text = song.songTitle
        cell.detailTextLabel?.text = song.artistName

        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            // Delete the row from the data source
            guard let playlist = playlist else { return }
            let song = playlist.songs[indexPath.row]
            
            PlaylistModelController.shared.deleteSongFrom(playlist: playlist, songToDelete: song)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
