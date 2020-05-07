import UIKit

class PlaylistTableViewController: UITableViewController {
    
    // MARK: _@IBOutlet
    @IBOutlet weak var playlistNameTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        PlaylistModelController.shared.loadFromPersistence()
    }
    
    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          tableView.reloadData()
      }
    
    // MARK: _@IBAction
    @IBAction func addPlaylist(_ sender: Any) {
        guard let playlistName = playlistNameTextField.text, !playlistName.isEmpty else { return }
        PlaylistModelController.shared.createPlaylist(playlistName: playlistName)
        
        playlistNameTextField.text = ""
        tableView.reloadData()
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        PlaylistModelController.shared.playlists.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playlistCell", for: indexPath)

        // Configure the cell...
        let playlist = PlaylistModelController.shared.playlists[indexPath.row]
        cell.textLabel?.text = playlist.playlistName
        cell.detailTextLabel?.text = "Count: \(playlist.songs.count)"

        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            // Delete the row from the data source
            let playlistToDelete = PlaylistModelController.shared.playlists[indexPath.row]
            PlaylistModelController.shared.deletePlaylist(playlistTodelete: playlistToDelete)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toSongVC" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            guard let destinationVC = segue.destination as? SongTableViewController else { return }
            
            let playlist = PlaylistModelController.shared.playlists[indexPath.row]
            destinationVC.playlist = playlist
        }
    }
}
