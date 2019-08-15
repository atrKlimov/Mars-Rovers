//
//  PhotoTableViewCell.swift
//  MarsRovers
//
//  Created by Artem Klimov on 12/08/2019.
//  Copyright © 2019 Artem Klimov. All rights reserved.
//

import UIKit
import Kingfisher

class PhotoTableViewCell: UITableViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var photo: RoverPhoto! {
        didSet {
            if let url = URL(string: photo.photoUrl) {
                photoImageView.kf.setImage(with: url)
            }
        }
    }

}
