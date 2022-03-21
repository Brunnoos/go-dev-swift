import UIKit

class AlbumTrackTableViewCell: UITableViewCell {
    
    static let identifier = "AlbumTrackTableViewCell"
    @IBOutlet weak var trackNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(trackName: String) {
        trackNameLabel.text = trackName
    }
}
