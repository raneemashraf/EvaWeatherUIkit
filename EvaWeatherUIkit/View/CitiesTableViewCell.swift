//
//  CitiesTableViewCell.swift
//  EvaWeatherUIkit
//
//  Created by raneem on 23/07/2024.
//

import UIKit

class CitiesTableViewCell: UITableViewCell {

    @IBOutlet weak var favLabel: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
