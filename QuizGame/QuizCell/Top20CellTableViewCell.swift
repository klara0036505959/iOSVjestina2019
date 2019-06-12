//
//  Top20CellTableViewCell.swift
//  QuizGame
//
//  Created by Five Admin on 6/5/19.
//  Copyright © 2019 Five Admin. All rights reserved.
//

import UIKit

class Top20CellTableViewCell: UITableViewCell {

    @IBOutlet weak var userIdLabel: UILabel!
    
    @IBOutlet weak var numberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
