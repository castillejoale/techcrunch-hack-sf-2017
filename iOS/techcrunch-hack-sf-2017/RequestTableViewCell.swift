//
//  RequestTableViewCell.swift
//  
//
//  Created by Alejandro Castillejo on 9/16/17.
//
//

import UIKit

class RequestTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var emojisLabel: UILabel!
    
    var request:Request?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
